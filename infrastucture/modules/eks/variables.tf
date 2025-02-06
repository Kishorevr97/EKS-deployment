variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster."
}

variable "cluster_role_arn" {
  type        = string
  description = "The ARN of the EKS cluster role."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs for the EKS cluster."
}

/*variable "fargate_profile_name" {
  type        = string
  description = "The name of the Fargate profile."
}

variable "fargate_role_arn" {
  type        = string
  description = "The ARN of the Fargate pod execution role."
}

variable "fargate_namespace" {
  type        = string
  description = "The Kubernetes namespace for Fargate."
}*/
