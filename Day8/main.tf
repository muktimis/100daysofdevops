module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  aws_region   = var.aws_region
}


module "ec2" {
  source             = "./modules/ec2"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  user_data_path     = "${path.module}/scripts/user_data.sh"
  security_group_id  = module.vpc.default_security_group_id
  key_name           = var.key_name
}