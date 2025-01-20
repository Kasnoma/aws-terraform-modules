output "db_instance_id" {
  description = "The ID of the RDS instance."
  value       = aws_db_instance.this.id
}

output "db_endpoint" {
  description = "The connection endpoint for the RDS instance."
  value       = aws_db_instance.this.endpoint
}

output "db_arn" {
  description = "The ARN of the RDS instance."
  value       = aws_db_instance.this.arn
}

output "db_username" {
  description = "The master username for the database."
  value       = aws_db_instance.this.username
}
# output "database_subnet_id" {
#   description = "The master username for the database."
#   value       = aws_db_instance.this.username
# }

# output "public_subnet_id" {
#   value = aws_subnet.public.id
# }