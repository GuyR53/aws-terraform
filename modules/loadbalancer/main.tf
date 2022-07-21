# app load balancer
resource "aws_lb" "elb" {
  name               = "dev-to"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    var.public_security_group]
  subnets            = [var.public_subnet_id_az1,var.public_subnet_id_az2]

  tags = {
    Name = "dev-to"
    Project = "dev-to"
    Billing = "dev-to"
  }
}
# target group -> ecs
resource "aws_lb_target_group" "ecs" {
  name     = "ecs"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "dev-to"
    Project = "dev-to"
    Billing = "dev-to"
  }
}
# lb listener
resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.elb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}