resource "aws_db_subnet_group" "kinetic" {
  name       = "kinetic-subnet-group"
  subnet_ids = var.subnet_id  # Pass subnet IDs as input
  
  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}


resource "aws_db_instance" "this" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  #name                   = var.db_name
  username               = var.username
  password               = var.password
  db_name                 = var.db_identifier
  #subnet_id             = [var.subnet_id]
  parameter_group_name   = var.parameter_group_name
  publicly_accessible    = var.publicly_accessible
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = [var.db_security_group_id] #var.vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name
  multi_az               = var.multi_az
  storage_encrypted      = var.storage_encrypted
  backup_retention_period = var.backup_retention_period

    depends_on = [
    aws_db_subnet_group.kinetic 
    ]

  #tags = var.tags
  tags = {
    Name = "${var.name}-Database"
    Environment =var.environment
  }
}




 # root-module/main.tf

# module "database" {
#   source = "../database-module" # Path to the database module

#   allocated_storage      = 20
#   storage_type           = "gp2"
#   engine                 = "mysql"
#   engine_version         = "8.0"
#   instance_class         = "db.t3.micro"
#   db_name                = "exampledb"
#   username               = "admin"
#   password               = "securepassword"
#   parameter_group_name   = "default.mysql8.0"
#   publicly_accessible    = false
#   vpc_security_group_ids = ["sg-0123456789abcdef0"]
#   db_subnet_group_name   = "example-subnet-group"
#   multi_az               = false
#   backup_retention_period = 7
#   skip_final_snapshot    = true

#   subnet_ids = ["subnet-0123456789abcdef0", "subnet-abcdef0123456789"]

#   tags = {
#     Name        = "example-database"
#     Environment = "production"
#   }
# }
