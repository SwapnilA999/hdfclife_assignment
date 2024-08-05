provider "aws" {
  region = var.region
}


module "vpc" {
  source                = "./vpc_module"
  region                = var.region
  vpc_cidr_block        = var.vpc_cidr_block
  vpc_instance_tenancy  = var.vpc_instance_tenancy
  vpc_name              = var.vpc_name
  availability_zone_1   = var.availability_zone_1
  availability_zone_2   = var.availability_zone_2
  pub_subnet1_cidr      = var.pub_subnet1_cidr
  pub_subnet1_name      = var.pub_subnet1_name
  pub_subnet2_cidr      = var.pub_subnet2_cidr
  pub_subnet2_name      = var.pub_subnet2_name
  priv_subnet1_cidr     = var.priv_subnet1_cidr
  priv_subnet1_name     = var.priv_subnet1_name
  priv_subnet2_cidr     = var.priv_subnet2_cidr
  priv_subnet2_name     = var.priv_subnet2_name
  pub_route_table_name  = var.pub_route_table_name
  priv_route_table_name = var.priv_route_table_name
}


module "ec2" {
  source = "./ec2_module"
  pub_instance_name       = var.pub_instance_name
  instance_ami            = var.instance_ami
  bastion_instance_type   = var.bastion_instance_type
  key_name                = var.key_name
  pubsecgrp               = var.pubsecgrp
  vpc                     = module.vpc.vpc_id
  public_subnet_id        = module.vpc.subnet01_id
}


module "rds" {
  source = "./rds_module"
  region                   = var.region
  db_instance_identifier   = var.db_instance_identifier
  rds_storage_type         = var.rds_storage_type
  allocated_storage        = var.allocated_storage
  db_username              = var.db_username
  db_password              = var.db_password
  rds_publicly_accessible  = var.rds_publicly_accessible
  security_group_name      = var.security_group_name
  security_group_cidr      = var.security_group_cidr
  rds_engine               = var.rds_engine
  rds_engine_version       = var.rds_engine_version
  rds_instance_class       = var.rds_instance_class
  rds_parameter_group_name = var.rds_parameter_group_name
  rds_skip_final_snapshot  = var.rds_skip_final_snapshot
  rds_option_group_name    = var.rds_option_group_name
  db_subnet_group          = [module.vpc.subnet03_id, module.vpc.subnet04_id]
  vpc_id                   = module.vpc.vpc_id
}



module "ecs" {
  source = "./ecs_module"

  aws_region                = var.aws_region
  cluster_name              = var.cluster_name
  task_definition_name      = var.task_definition_name
  task_cpu                  = var.task_cpu
  task_memory               = var.task_memory
  container_name            = var.container_name
  container_image           = var.container_image
  container_port            = var.container_port
  service_name              = var.service_name
  desired_count             = var.desired_count
  private_subnet_ids        = [module.vpc.subnet03_id,module.vpc.subnet04_id]
  vpc_id                    = module.vpc.vpc_id
  subnets 		    = [module.vpc.subnet01_id,module.vpc.subnet02_id]
}

