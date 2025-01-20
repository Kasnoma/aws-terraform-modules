output "vpc_id" {
  value = aws_vpc.main.id
}

# output "public_subnet_id" {
#   value = aws_subnet.public.id
# }

# output "instance_sg_id" {
#   value = aws_security_group.instance_sg.id
# }
output "web_security_group_id" {
  value = aws_security_group.web_sg.id
}

output "db_security_group_id" {
  value = aws_security_group.db_sg.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}
