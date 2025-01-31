module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones   = var.availability_zones
  environment         = var.environment
}

module "eks" {
  source               = "../../modules/eks"
  cluster_name         = "my-eks-cluster"
  cluster_role_arn     = module.iam.eks_cluster_role_arn
  private_subnet_ids          = module.vpc.private_subnet_ids
  fargate_profile_name = "fargate-profile"
  fargate_role_arn     = module.iam.fargate_pod_execution_role_arn
  fargate_namespace    = "default"
}

module "iam" {
  source                = "../../modules/iam"
  cluster_role_name     = "eks-cluster-role"
  fargate_role_name     = "eks-fargate-execution-role"
}

module "ecr" {
  source      = "../../modules/ecr"
  repository_name = "my-ecr-repo-${var.environment}"
  environment = var.environment
}


