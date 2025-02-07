module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones   = var.availability_zones
  environment         = var.environment
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

module "eks" {
  source               = "../../modules/eks"
  cluster_name         = "my-eks-cluster"
  cluster_role_arn     = module.iam.eks_cluster_role_arn
  private_subnet_ids          = module.vpc.private_subnet_ids
  eks_node_role_arn  = module.iam.eks_node_role_arn 
  vpc_id       = module.vpc.vpc_id
}

module "iam" {
  source                = "../../modules/iam"
  cluster_role_name     = "eks-cluster-role"
  node_role_name    = "eks-node-group-role"
}

module "ecr" {
  source      = "../../modules/ecr"
  repository_name = "my-ecr-repo-${var.environment}"
  environment = var.environment
}


