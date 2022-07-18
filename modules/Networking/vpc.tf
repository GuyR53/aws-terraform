
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



# Public Subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name  = "${var.environment}-PublicSubnet"
    Environment = "${var.environment}"
  }
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

# Internet Gateway for internet access to the vpc
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-InternetGTW"
    Environment = "${var.environment}"
  }
}

# Nat gateway for public subnet
resource "aws_nat_gateway" "example" {
  connectivity_type = "private"
  subnet_id   = aws_subnet.PublicSubnet.id

    tags = {
    Name = "${var.environment}-NatGateway"
    Environment = "${var.environment}"
  }
}