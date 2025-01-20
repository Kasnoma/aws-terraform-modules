variable "instance_count" {
  description = "Number of instances"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH key name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the instances"
  type        = string
}

# variable "subnet_id" {
#   description = "List of Subnet IDs for the instances"
#   type        = list(string)
#   # default     = ["subnet-abc12345", "subnet-def67890"]
# }

# variable "security_group_id" {
#   description = "Security group ID for the instances"
#   type        = string
# }

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}
variable "web_security_group_id" {
  description = "The security group ID for the web server."
  type        = string
}

variable "db_security_group_id" {
  description = "The security group ID for the database server."
  type        = string
}

variable "name" {
  description = "Project name"
  type        = string
  default     = "MyApp"
}
