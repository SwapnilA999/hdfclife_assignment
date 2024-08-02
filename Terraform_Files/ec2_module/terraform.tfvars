instance_ami            = "ami-060e277c0d4cce553"
bastion_instance_type   = "t2.micro"
vpc			 = module.vpc.vpc_id
key_name                = "uat-key"
pubsecgrp               = "uat-bastion-sg"
pub_instance_name       = "uat-bastion-host"
public_subnet_id        = module.vpc.subnet01_id
