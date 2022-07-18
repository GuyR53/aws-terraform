
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