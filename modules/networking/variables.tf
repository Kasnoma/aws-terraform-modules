variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

# variable "public_subnet_cidr" {
#   description = "Public subnet CIDR block"
#   type        = string
# }

# variable "availability_zone" {
#   description = "Availability zone"
#   type        = string
# }

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}
variable "name" {
  description = "Project name"
  type        = string
  default     = "MYAPP"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.64.0/18", "10.0.128.0/18"] # Example CIDRs
}
