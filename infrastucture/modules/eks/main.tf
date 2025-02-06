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
/*resource "aws_eks_fargate_profile" "main" {
  cluster_name = aws_eks_cluster.main.name
  fargate_profile_name = var.fargate_profile_name
  pod_execution_role_arn = var.fargate_role_arn

  selector {
    namespace = var.fargate_namespace
  }

  # Optionally, you can associate specific subnets to the Fargate profile
  subnet_ids = var.private_subnet_ids
}*/


# Managed Node Group for EC2-based Worker Nodes
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "eks-node-group"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  instance_types = ["t3.medium"]
  disk_size      = 20

  remote_access {
    ec2_ssh_key = var.ssh_key_name  # Add your SSH key for access
  }
}
