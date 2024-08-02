

module "vpc" {
  source = "./vpc_module"
  region = "ap-southeast-1"
  vpc_cidr_block       = "10.0.0.0/16"
  vpc_instance_tenancy = "default"
  vpc_name             = "uat-vpc"
  availability_zone_1  = "ap-southeast-1a"
  availability_zone_2  = "ap-southeast-1b"
  pub_subnet1_cidr    = "10.0.1.0/24"
  pub_subnet1_name    = "uat-public-subnet-1"
  pub_subnet2_cidr    = "10.0.3.0/24"
  pub_subnet2_name    = "uat-public-subnet-2"
  priv_subnet1_cidr   = "10.0.2.0/24"
  priv_subnet1_name   = "uat-private-subnet-1"
  priv_subnet2_cidr   = "10.0.4.0/24"
  priv_subnet2_name   = "uat-private-subnet-2"
  pub_route_table_name = "uat-public-rt"
  priv_route_table_name = "uat-private-rt"

}

module "ec2" {
  source = "./ec2_module"
  pub_instance_name       = "uat-bastion-host"
  instance_ami            = "ami-060e277c0d4cce553"
  bastion_instance_type   = "t2.micro"
  key_name                = "uat-key"
  pubsecgrp               = "uat-bastion-sg"
  vpc                     = module.vpc.vpc_id
  public_subnet_id        = module.vpc.subnet01_id
}

module "rds" {
  source = "./rds_module"
  region                   = "ap-southeast-1"
  db_instance_identifier   = "uat-db"
  rds_storage_type         = "gp2"
  allocated_storage        = 80
  db_username              = "admin"
  db_password              = "password"
  rds_publicly_accessible  = false
  security_group_name      = "uat-rds-sg"
  security_group_cidr      = "0.0.0.0/0"
  rds_engine               = "mysql"
  rds_engine_version       = "8.0.35"
  rds_instance_class       = "db.t3.micro"
  rds_parameter_group_name = "default.mysql8.0"
  rds_skip_final_snapshot  = true
  rds_option_group_name    = "default:mysql-8-0"
  db_subnet_group          = [module.vpc.subnet03_id, module.vpc.subnet04_id]
  vpc_id                   = module.vpc.vpc_id
}

