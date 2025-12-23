data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

module "network" {
  source = "../../modules/network"

  name_prefix          = local.name_prefix
  vpc_cidr             = var.vpc_cidr
  azs                  = local.azs
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  tags                 = local.tags
}

module "compute" {
  source = "../../modules/compute_ec2"

  name_prefix                 = local.name_prefix
  vpc_id                      = module.network.vpc_id
  subnet_id                   = module.network.public_subnet_ids[0]
  instance_type               = var.instance_type
  ssh_ingress_cidr_blocks     = var.ssh_ingress_cidr_blocks
  enable_http                 = var.enable_http
  associate_public_ip_address = true
  user_data                   = local.nginx_user_data
  tags                        = local.tags
}

module "storage" {
  source = "../../modules/storage_s3"

  bucket_name       = local.bucket_name
  enable_versioning = true
  force_destroy     = true
  tags              = local.tags
}
