environment = "development-env"
repository_name = "dev-ecr-repo"
vpc_cidr            = "10.2.0.0/16"
public_subnet_cidr = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnet_cidr = ["10.2.3.0/24", "10.2.4.0/24"]
availability_zones = ["eu-north-1b", "eu-north-1c"]
execution_role_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
