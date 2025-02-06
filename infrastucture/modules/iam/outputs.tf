output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "ARN of the IAM role for the worker nodes"
  value       = aws_iam_role.eks_node_role.arn
}
output "eks_worker_node_policy_attachment" {
  value = aws_iam_role_policy_attachment.eks_worker_node
}

output "eks_cni_policy_attachment" {
  value = aws_iam_role_policy_attachment.eks_cni_policy
}

/*output "fargate_pod_execution_role_arn" {
  value = aws_iam_role.fargate_pod_execution_role.arn
}*/
