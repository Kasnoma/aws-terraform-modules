variable "allocated_storage" {
  description = "The amount of storage allocated to the database (in GB)."
  type        = number
  default     = 20
}

variable "engine" {
  description = "The database engine (e.g., mysql, postgres, etc.)."
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The version of the database engine."
  type        = string
}

variable "instance_class" {
  description = "The instance class for the database (e.g., db.t3.micro)."
  type        = string
  default     = "db.t3.micro"
}

variable "username" {
  description = "The master username for the database."
  type        = string
}

variable "password" {
  description = "The master password for the database."
  type        = string
  sensitive   = true
}

variable "db_identifier" {
  description = "The master password for the database."
  type        = string
  default = "myApP0212"
}

variable "parameter_group_name" {
  description = "The parameter group name to use for the database."
  type        = string
  default     = null
}

variable "publicly_accessible" {
  description = "Whether the database should be publicly accessible."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when the database is deleted."
  type        = bool
  default     = true
}

variable "vpc_security_group_ids" {
  description = "The security group IDs to assign to the database."
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group."
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Whether the database should be deployed in a Multi-AZ configuration."
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Whether to enable encryption at rest for the database."
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "The number of days to retain database backups."
  type        = number
  default     = 7
}

variable "tags" {
  description = "A map of tags to assign to the database."
  type        = map(string)
  default     = {}
}

variable "db_name" {
  description = "A map of tags to assign to the database."
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}
variable "name" {
  description = "Project name"
  type        = string
  default     = "MyApp"
}

variable "db_security_group_id" {
  description = "The security group ID for the database server."
  type        = string
}

# variable "subnet_ids" {
#   description = "Subnet ID for the instances"
#   type        = string
#   default     = us-east-1a
# }


variable "subnet_id" {
  description = "List of Subnet IDs for the instances"
  type        = list(string)
  # default     = ["subnet-abc12345", "subnet-def67890"]
}
