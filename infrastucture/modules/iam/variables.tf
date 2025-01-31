variable "vpc_id" {
  description = "VPC ID for the security group"
  type = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type = string
}
variable "execution_role_policy_arn" {
  description = "ARN of the IAM policy for ECS task execution"
  type        = string
}
