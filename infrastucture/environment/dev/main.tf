module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones   = var.availability_zones
  environment         = var.environment
}

module "eks" {
  source = "../../modules/eks"
  cluster_name = "dev-eks-cluster"
  cluster_role_arn = module.iam.eks_cluster_role_arn
  subnet_ids   = module.vpc.public_subnet_ids
}

module "iam" {
  source                      = "../../modules/iam"
  execution_role_policy_arn   = var.execution_role_policy_arn
  vpc_id                      = module.vpc.vpc_id
  environment                 = var.environment
}

module "ecr" {
  source      = "../../modules/ecr"
  repository_name = "my-ecr-repo-${var.environment}"
  environment = var.environment
}


