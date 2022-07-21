
# Route Table for public subnet AZ1
resource "aws_route_table" "publicroute_az1" {
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
# Associate the public route table to the public subnet AZ1
resource "aws_route_table_association" "publicassociation_az1" {
  subnet_id      = aws_subnet.PublicSubnet_AZ1.id
  route_table_id = aws_route_table.publicroute_az1.id

}

# Route Table for public subnet AZ2
resource "aws_route_table" "publicroute_az2" {
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

# Associate the public route table to the public subnet AZ2
resource "aws_route_table_association" "publicassociation_az2" {
  subnet_id      = aws_subnet.PublicSubnet_AZ2.id
  route_table_id = aws_route_table.publicroute_az2.id

}

# Route Table for private subnet
resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.vpc.id

   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_nat_gateway.Natgateway.id
  }
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