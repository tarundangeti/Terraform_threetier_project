module "vpc" {

  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block

  public_lb_cidr_block_1 = var.public_lb_cidr_block_1
  public_lb_cidr_block_2 = var.public_lb_cidr_block_2

  public_lb_az_1 = var.public_lb_az_1
  public_lb_az_2 = var.public_lb_az_2

  private_ec2_cidr_block = var.private_ec2_cidr_block
  private_ec2_az         = var.private_ec2_az

  private_db_cidr_block = var.private_db_cidr_block
  private_db_az         = var.private_db_az
}

module "ec2" {

  source = "./modules/ec2"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  private_subnet_id  = module.vpc.private_ec2_subnet_id
  ec2_security_group = module.vpc.ec2_security_group
  key_name           = var.key_name
}


module "alb" {

  source = "./modules/alb"

  vpc_id = module.vpc.vpc_id

  public_subnet_ids = [
    module.vpc.public_lb_subnet_id_1,
    module.vpc.public_lb_subnet_id_2
  ]

  lb_security_group = module.vpc.lb_security_group
  ec2_instance_id   = module.ec2.instance_id
}
