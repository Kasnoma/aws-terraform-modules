terraform {
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
}
  
  required_version = ">= 1.0"
   backend "s3" {
     bucket = "kinetics-terraform-state-1a"
     key    = "terraform/state" 
     region = "us-east-1" 
   }
 }


# Define provider
provider "aws" {
  region = var.aws_region
}

# Call the networking module
module "networking" {
  source               = "../modules/networking"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  availability_zones    = var.availability_zones
}

# Call the compute module
module "compute" {
  source                = "../modules/compute"
  instance_count        = var.instance_count
  instance_type         = var.instance_type
  ssh_key_name          = var.ssh_key_name
  subnet_id             = module.networking.public_subnet_ids[0]
  #security_group_id     = module.networking.instance_sg_id
  web_security_group_id  = module.networking.web_security_group_id
  db_security_group_id   = module.networking.db_security_group_id
}

# module "database" {
#   source                = "../database"
#   allocated_storage     = 50
#   engine                = "postgres"
#   engine_version        = "14.5"
#   instance_class        = "db.t3.medium"
#   db_name               = "mydatabase"
#   username              = "admin"
#   password              = "securepassword123"
#   parameter_group_name  = null
#   publicly_accessible   = false
#   skip_final_snapshot   = true
#   vpc_security_group_ids = ["sg-12345678"]
#   db_subnet_group_name  = "my-db-subnet-group"
#   multi_az              = true
#   storage_encrypted     = true
#   backup_retention_period = 7
#   tags = {
#     Environment = "Production"
#     Project     = "MyApp"
#   }
# }

module "database" {
  source                = "../modules/database"
  allocated_storage     = var.allocated_storage
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  #db_name               = var.db_name
  subnet_id             = module.networking.private_subnet_ids
  username              = var.username
  password              = var.password
  parameter_group_name  = var.parameter_group_name
  publicly_accessible   = var.publicly_accessible
  skip_final_snapshot   = var.skip_final_snapshot
  db_security_group_id   = module.networking.db_security_group_id
  vpc_security_group_ids = module.networking.db_security_group_id
  db_subnet_group_name  = var.db_subnet_group_name
  multi_az              = var.multi_az
  storage_encrypted     = var.storage_encrypted
  backup_retention_period = var.backup_retention_period
}


