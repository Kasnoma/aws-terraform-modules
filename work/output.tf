output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_id" {
  value = module.networking.public_subnet_ids
}

# output "instance_ids" {
#   value = module.compute.instance_ids
# }
output "web_instance_ids" {
  value = module.compute.web_instance_ids #aws_instance.web[*].id
}

output "db_instance_ids" {
  value = module.compute.db_instance_ids #aws_instance.db[*].id
}

output "private_subnet_id" {
  value = module.networking.private_subnet_ids
}


# output "vpc_id" {
#   value = module.networking.main.id
# }

# output "public_subnet_id" {
#   value = module.networking.public.id
# }

# output "instance_sg_id" {
#   value = aws_security_group.instance_sg.id
# }

output "web_security_group_id" {
  value = module.networking.db_security_group_id
}

# output "web_security_group_id" {
#   value = aws_security_group.web_sg.id
# }

# output "db_security_group_id" {
#   value = aws_security_group.db_sg.id
# }

output "db_security_group_id" {
  value = module.networking.web_security_group_id
}

output "db_instance_id" {
  description = "The ID of the RDS instance."
  value       = module.database.db_instance_id
}

output "db_endpoint" {
  description = "The connection endpoint for the RDS instance."
  value       = module.database.db_endpoint
}

output "db_arn" {
  description = "The ARN of the RDS instance."
  value       = module.database.db_arn
}

output "db_username" {
  description = "The master username for the database."
  value       = module.database.db_username
}
