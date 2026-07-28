data "aws_availability_zones" "available" { state = "available" }

data "aws_caller_identity" "current" {}

locals {
  name = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Portfolio   = "true"
  }
}

module "vpc" {
  source             = "../../modules/vpc"
  name               = local.name
  vpc_cidr           = var.vpc_cidr
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
  tags               = local.common_tags
}

module "ecr" {
  source = "../../modules/ecr"
  name   = "${var.project_name}-app"
  tags   = local.common_tags
}

module "eks" {
  source             = "../../modules/eks"
  name               = local.name
  cluster_version    = var.cluster_version
  private_subnet_ids = module.vpc.private_subnet_ids
  tags               = local.common_tags
}

module "monitoring" {
  source       = "../../modules/monitoring"
  cluster_name = module.eks.cluster_name
  tags         = local.common_tags
}
