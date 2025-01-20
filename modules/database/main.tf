resource "aws_db_subnet_group" "hellworld" {
  name       = "myapp-subnet-group"
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
