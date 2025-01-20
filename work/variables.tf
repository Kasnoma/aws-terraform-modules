variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1" # Adjust as necessary
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

# variable "public_subnet_cidr" {
#   description = "Public subnet CIDR block"
#   type        = string
#   default     = "10.0.1.0/24"
# }

# variable "availability_zone" {
#   description = "Availability zone for the resources"
#   type        = string
#   default     = "us-east-1b"
# }

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.64.0/18", "10.0.128.0/18"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ssh_key_name" {
  description = "SSH key name for EC2 instances"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of storage allocated to the database (in GB)."
  type        = number
  default     = 20 # Example default
}

variable "engine" {
  description = "The database engine (e.g., mysql, postgres, etc.)."
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The version of the database engine."
  type        = string
  default     = "8.0.39"
}

variable "instance_class" {
  description = "The instance class for the database."
  type        = string
  default     = "db.t3.medium"
}

variable "db_name" {
  description = "The name of the database."
  type        = string
  default     = "myapp"
}

variable "username" {
  description = "The master username for the database."
  type        = string
  default     = "myappmaster"
}

variable "password" {
  description = "The master password for the database."
  type        = string
  sensitive   = true
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

# variable "vpc_security_group_ids" {
#   description = "The security group IDs to assign to the database."
#   type        = list(string)
# }

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group."
  type        = string
  default     = "myapp-subnet-group"
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
  default     = {
    Environment = "Production"
    Project     = "MyApp"
  }
}
