variable "cluster_role_name" {
  type        = string
  description = "The name of the IAM role for the EKS cluster."
}

variable "fargate_role_name" {
  type        = string
  description = "The name of the IAM role for Fargate pod execution."
}
