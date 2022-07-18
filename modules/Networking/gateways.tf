
# Internet Gateway for internet access to the vpc
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-InternetGTW"
    Environment = "${var.environment}"
  }
}

# Elastic IP for the Nat Gateway
resource "aws_eip" "natip" {
  vpc      = true
}

# Nat gateway for public subnet
resource "aws_nat_gateway" "Natgateway" {
  connectivity_type = "public"
  allocation_id = aws_eip.natip.id
  subnet_id   = aws_subnet.PublicSubnet.id

    tags = {
    Name = "${var.environment}-NatGateway"
    Environment = "${var.environment}"
  }
}