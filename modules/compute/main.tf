resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "ssh_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${var.ssh_key_name}.pem"
  file_permission = "0400"
}
 

# resource "aws_instance" "web" {
#   count         = var.instance_count
#   ami           = "ami-0d64bb532e0502c46" # Replace with a valid AMI for your region
#   instance_type = var.instance_type
#   key_name      = aws_key_pair.generated_key.key_name #var.ssh_key_name
#   subnet_id     = var.subnet_id

#   vpc_security_group_ids = [var.security_group_id]

#   tags = {
#     Name = "${var.environment}-instance-${count.index}"
#   }
# }

# resource "aws_iam_role" "ssm_role" {
#   name               = "${var.environment}-ssm-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# # Attach the AmazonEC2RoleforSSM policy to the role
# resource "aws_iam_role_policy_attachment" "ssm_attachment" {
#   role       = aws_iam_role.ssm_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2RoleforSSM"
# }

# Web Server Instance
resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = "ami-0e1bed4f06a3b463d"  # Replace with a valid AMI ID
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name
  subnet_id     = var.subnet_id #module.networking.public_subnet_id
  vpc_security_group_ids = [var.web_security_group_id] #[module.networking.web_security_group_id]

#  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"

  tags = {
    Name = "${var.name}-WebServer"
    Environment =var.environment
  }
}

# Database Server Instance
resource "aws_instance" "db" {
  count         = var.instance_count #1
  ami           = "ami-0e1bed4f06a3b463d"  # Replace with a valid AMI ID
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name
  subnet_id     = var.subnet_id #module.networking.public_subnet_id #correct this
  vpc_security_group_ids = [var.db_security_group_id] #[module.networking.db_security_group_id]

 # iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  
  tags = {
    Name = "${var.name}-DatabaseServer"
    Environment =var.environment
  }
}

# # IAM Instance Profile to attach SSM Role to EC2 instances
# resource "aws_iam_instance_profile" "ssm_instance_profile" {
#   name = "${var.environment}-ssm-profile"
#   role = aws_iam_role.ssm_role.name
# }
