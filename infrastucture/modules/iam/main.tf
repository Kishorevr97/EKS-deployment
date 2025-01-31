resource "aws_iam_role" "eks_cluster_role" {
  name = "eksClusterRole"
  assume_role_policy = file("${path.module}/policies/eks_cluster_policy.json")
}


resource "aws_iam_role" "eks_task_role" {
  name = "${var.environment}-eks-task-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "eks-tasks.amazonaws.com"
      }
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_execution_role" {
  role       = aws_iam_role.eks_execution_role.name
  policy_arn = var.execution_role_policy_arn
}


# Security Group for EkS Tasks (can be used for both services)
resource "aws_security_group" "eks_security_group" {
  name        = "${var.environment}-eks-sg"
  description = "Security group for EkS tasks"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS traffic from anywhere
  }

  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
