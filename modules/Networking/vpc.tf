
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

