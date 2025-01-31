output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "fargate_pod_execution_role_arn" {
  value = aws_iam_role.fargate_pod_execution_role.arn
}
