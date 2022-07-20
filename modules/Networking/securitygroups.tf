# Public Security Group
resource "aws_security_group" "public" {
  name = "${var.environment}-public-sg"
  description = "Public internet access"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-public-sg"
    Role        = "public"
    Environment = var.environment
  }
}
# Allow all outbound
resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}
# Allow my computer to ssh
resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["79.178.241.159/32"]
  security_group_id = aws_security_group.public.id
}
# Allow all http to app
resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}

# Private Security Group
resource "aws_security_group" "private" {
  name = "${var.environment}-private-sg"
  description = "Private internet access"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-private-sg"
    Role        = "private"
    Environment = var.environment
  }
}
# Allow all outbound
resource "aws_security_group_rule" "private_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.private.id
}
# Allow 5432 for app machines to access the db
resource "aws_security_group_rule" "private_in_postgres" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks = [aws_subnet.PublicSubnet.cidr_block]

  security_group_id = aws_security_group.private.id
}
# Allow ssh to app machines for debugging
resource "aws_security_group_rule" "private_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = [aws_subnet.PublicSubnet.cidr_block]

  security_group_id = aws_security_group.private.id
}