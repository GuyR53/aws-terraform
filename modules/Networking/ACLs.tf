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
# Allow inbound port 22 to my computer
resource "aws_network_acl_rule" "public_in_ssh" {
  egress         = false
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_block       = "0.0.0.0/0"

  network_acl_id = aws_network_acl.public.id
  rule_action       = "allow"
  rule_number       = 2
}
# Allow inbound port 8080
resource "aws_network_acl_rule" "public_in_http" {
  egress         = false
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_block       = "0.0.0.0/0"

  network_acl_id = aws_network_acl.public.id
  rule_action       = "allow"
  rule_number       = 3
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

# Allow port 5432 inbound from vpc
resource "aws_network_acl_rule" "private_in" {
  egress         = false
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_block= aws_vpc.vpc.cidr_block

  network_acl_id = aws_network_acl.private.id
  rule_action       = "allow"
  rule_number       = 2
}

