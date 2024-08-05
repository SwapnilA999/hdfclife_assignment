region = "us-east-1"

# vpc:

vpc_cidr_block       = "10.0.0.0/16"
vpc_instance_tenancy = "default"
vpc_name             = "tf-vpc"

#availability_zones:
availability_zone_1 = "us-east-1a"
availability_zone_2 = "us-east-1b"

# pub_subnets:
pub_subnet1_cidr    = "10.0.1.0/24"
pub_subnet1_name    = "tf-pub1-subnet"
pub_subnet2_cidr    = "10.0.3.0/24"
pub_subnet2_name    = "tf-pub2-subnet"


# priv_subnets:
priv_subnet1_cidr   = "10.0.2.0/24"
priv_subnet1_name   = "tf-pri1-subnet"
priv_subnet2_cidr   = "10.0.4.0/24"
priv_subnet2_name   = "tf-pri2-subnet"

# pub_route_table:
pub_route_table_name = "tf-pubroute"

# priv_route_table:
priv_route_table_name = "tf-priroute"


#ec2_instance
instance_ami            = "ami-04a81a99f5ec58529"
bastion_instance_type   = "t2.micro"
vpc			= module.vpc.vpc_id
key_name                = "uat-key"
pubsecgrp               = "uat-bastion-sg"
pub_instance_name       = "uat-bastion-host"
public_subnet_id        =  module.vpc.subnet01_id


#rds

#region 		 = "us-east-1"		
db_instance_identifier   = "uat-db"
rds_storage_type         = "gp2"
allocated_storage        = 20
db_username              = "admin"
db_password              = "password123"
rds_publicly_accessible  = false
security_group_name      = "uat-rds-sg"
security_group_cidr      = "0.0.0.0/0"
rds_engine               = "mysql"
rds_engine_version       = "8.0.35"
rds_instance_class       = "db.t3.micro"
rds_parameter_group_name = "default.mysql8.0"
rds_skip_final_snapshot  = true
rds_option_group_name    = "default:mysql-8-0"

#ecs

aws_region                 = "us-east-1"
  cluster_name              = "my-ecs-cluster"
  task_definition_name      = "my-task-definition"
  task_cpu                  = 256
  task_memory               = 512
  container_name            = "my-container"
  container_image           = "swapnil2026/netflix"
  container_port            = 80
  service_name              = "my-service"
  desired_count             = 2
  private_subnet_ids        = [module.vpc.subnet03_id,module.vpc.subnet04_id]
  vpc_id                    = module.vpc.vpc_id
  subnets 		    = [module.vpc.subnet01_id,module.vpc.subnet02_id]

