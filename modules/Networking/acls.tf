# Public ACL
resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [aws_subnet.PublicSubnet.id]
  tags = {
    Name        = "${var.environment}-public-acl"
    Role        = "public"
    Environment = var.environment
  }
}

# Allow all outbound
resource "aws_network_acl_rule" "public_out" {
  egress         = true
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_block = "0.0.0.0/0"

  network_acl_id = aws_network_acl.public.id
  rule_action       = "allow"
  rule_number       = 1
}
# Allow all inbound, because Network Access Control Lists (NACLs) are stateless. This means that sending a request in one direction does not automatically permit a response in the other direction.
resource "aws_network_acl_rule" "public_in" {
  egress         = false
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_block = "0.0.0.0/0"

  network_acl_id = aws_network_acl.public.id
  rule_action       = "allow"
  rule_number       = 4
}


# Private ACL
resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [aws_subnet.PrivateSubnet.id]

  tags = {
    Name        = "${var.environment}-private-acl"
    Role        = "private"
    Environment = var.environment
  }
}
# Allow outbound
resource "aws_network_acl_rule" "private_out" {
  egress         = true
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_block = "0.0.0.0/0"

  network_acl_id = aws_network_acl.private.id
  rule_action       = "allow"
  rule_number       = 1
}

# Allow all inbound, because Network Access Control Lists (NACLs) are stateless. This means that sending a request in one direction does not automatically permit a response in the other direction.
resource "aws_network_acl_rule" "private_in" {
  egress         = false
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_block = "0.0.0.0/0"

  network_acl_id = aws_network_acl.private.id
  rule_action       = "allow"
  rule_number       = 3
}



