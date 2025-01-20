# output "instance_ids" {
#   value = aws_instance.web[*].id
# }
output "web_instance_ids" {
  value = aws_instance.web[*].id
}

output "db_instance_ids" {
  value = aws_instance.db[*].id
}
# output "instance_ids" {
#   description = "List of instance IDs for the web and database servers."
#   value       = [aws_instance.web.id, aws_instance.db.id]
# }
