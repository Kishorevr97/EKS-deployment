
output "eks_cluster_name" {
  value = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "fargate_profile_name" {
  value = aws_eks_fargate_profile.main.fargate_profile_name
}
