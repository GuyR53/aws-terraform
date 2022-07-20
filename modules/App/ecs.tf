resource "aws_ecs_cluster" "thisapp" {
  name = "${var.environment}-ecs-cluster-app"

  tags = {
    Name = "${var.environment}-ecs-cluster-app"
    Environment = var.environment
  }
}

resource "aws_ecs_service" "this" {
  name            = "${var.environment}-ecs-service-app"
  cluster         = aws_ecs_cluster.thisapp.arn
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type = "FARGATE"


    network_configuration {
      assign_public_ip = true
      subnets = [var.public_subnet_id]
      security_groups = [var.public_security_group]
  }


    tags = {
    Name = "${var.environment}-ecs-service-app"
    Environment = var.environment
  }
}

