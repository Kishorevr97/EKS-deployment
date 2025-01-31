variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = list(string)
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones to use for subnets"
  type        = list(string)
  default     = ["eu-north-1b", "eu-north-1c"]  # Update with the zones you want to use
}


variable "execution_role_policy_arn" {
  description = "IAM policy ARN for ECS execution role"
  type        = string
}


variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type = string
}
variable "repository_name" {
  description = "ECR repository name"
  type        = string
}
