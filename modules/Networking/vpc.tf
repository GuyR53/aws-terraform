
# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}

# Internet Gateway for internet access to the vpc
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-InternetGTW"
    Environment = "${var.environment}"
  }
}

# Public Subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name  = "${var.environment}-PublicSubnet"
    Environment = "${var.environment}"
  }
}


# Route Table for public subnet
resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
   tags = {
    Name = "${var.environment}-PublicRoute"
    Environment = "${var.environment}"
  }
}
# Associate the public route table to the public subnet
resource "aws_route_table_association" "publicassociation" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.publicroute.id

}

# Private Subnet
resource "aws_subnet" "PrivateSubnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name="${var.environment}-PrivateSubnet"
    Environment = "${var.environment}"
  }
}

# Route Table for private subnet
resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.vpc.id

   tags = {
    Name = "${var.environment}-PrivateRoute"
    Environment = "${var.environment}"
  }
}

# Associate the private route table to the private subnet
resource "aws_route_table_association" "privateassociation" {
  subnet_id      = aws_subnet.PrivateSubnet.id
  route_table_id = aws_route_table.privateroute.id

}