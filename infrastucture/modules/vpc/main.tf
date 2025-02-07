resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Internet Gateway for public subnet access
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Public Subnets (with route table and IGW association)
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# Private Subnets (with route table and NAT gateway association)
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

# Route Table for public subnet (route to IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Route Table Association for public subnets
resource "aws_route_table_association" "public_association" {
  count         = length(var.public_subnet_cidrs)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

# NAT Gateway for private subnet internet access (optional, if needed)
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id  # Using the first public subnet for NAT
  depends_on    = [aws_eip.nat]
}

# Route Table for private subnets (route through NAT gateway)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

# Route Table Association for private subnets
resource "aws_route_table_association" "private_association" {
  count         = length(var.private_subnet_cidrs)
  subnet_id     = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
