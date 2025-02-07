variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zone" {
  description = "List of availability zones"
  type        = list(string)
}
