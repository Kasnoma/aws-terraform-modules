resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.name}-vpc"
  }
}

# resource "aws_subnet" "public" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = var.public_subnet_cidr
#   availability_zone = var.availability_zone
#   map_public_ip_on_launch = true
# }


resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-Public Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  
}

# resource "aws_route_table_association" "public_association" {
#   subnet_id      = aws_subnet.public.id
#   route_table_id = aws_route_table.public.id
# }

resource "aws_route_table_association" "public_association" {
  count         = length(aws_subnet.public)  # Ensure the count matches
  # subnet_id     = aws_subnet.public[count.index].id
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

}

# Security Group for Web Application Server
resource "aws_security_group" "web_sg" {
  name        = "${var.name}-web-sg"
  description = "Allow HTTP, HTTPS, and SSH access for the web application"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-web-sg"
  }
}

# Security Group for Database Server
resource "aws_security_group" "db_sg" {
  name        = "${var.name}-db-sg"
  description = "Allow MySQL access only from the web server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow MySQL from Web Server"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-db-sg"
    Environment = var.environment
  }
}

# Output Security Group IDs



# Security Group for EC2 instances
# resource "aws_security_group" "instance_sg" {
#   vpc_id = aws_vpc.main.id
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "${var.environment}-instance-sg"
#   }
# }


# Variable for private subnet CIDRs

# Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}-Private Subnet ${count.index + 1}"
  }
}

# NAT Gateway (one per availability zone for high availability)
resource "aws_eip" "nat" {
  count = length(var.availability_zones)

  # vpc      = true
  tags = {
    Name = "${var.name}-NAT EIP ${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count =  length(var.availability_zones)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.name}-NAT Gateway ${count.index + 1}"
  }
}

#Multiple ROUTE FOR MULTIPLE NATs
resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-Private Route Table ${count.index + 1}"
  }
}

resource "aws_route" "private_nat_access" {
  count = length(aws_nat_gateway.nat)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
  
}

# Associate private subnets with the private route tables
resource "aws_route_table_association" "private_association" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

#Multiple subnet to use one nat

# #Route for private subnets to use NAT Gateway
# resource "aws_route" "private_nat_access" {
#   #count = length(aws_nat_gateway.nat)

#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat[count.index].id
# }


# # Associate private subnets with the private route table
# resource "aws_route_table_association" "private_association" {
#   count = length(aws_subnet.private)

#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private.id
# }


# # Route Table for Private Subnets
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "${var.name}-Private Route Table"
#   }
# }
