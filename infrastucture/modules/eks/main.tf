resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  vpc_config {
    subnet_ids = var.private_subnet_ids
    endpoint_public_access = true
    endpoint_private_access = true
  }

  # Add additional tags or configurations as required
  tags = {
    Name = "eks-cluster"
  }
}

# Fargate Profile for EKS
resource "aws_eks_fargate_profile" "main" {
  cluster_name = aws_eks_cluster.main.name
  fargate_profile_name = var.fargate_profile_name
  pod_execution_role_arn = var.fargate_role_arn

  selector {
    namespace = var.fargate_namespace
  }

  # Optionally, you can associate specific subnets to the Fargate profile
  subnet_ids = var.private_subnet_ids
}
