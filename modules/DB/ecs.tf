resource "aws_ecs_cluster" "this" {
  name = "${var.environment}-ecs-cluster"

  tags = {
    Name = "${var.environment}-ecs-cluster"
    Environment = var.environment
  }
}

resource "aws_ecs_service" "this" {
  name            = "${var.environment}-ecs-service"
  cluster         = aws_ecs_cluster.this.arn
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type = "FARGATE"


    network_configuration {
      subnets = [var.private_subnet_id]
      security_groups = [var.private_security_group]
  }


    tags = {
    Name = "${var.environment}-ecs-service"
    Environment = var.environment
  }
}

# cloudwatch_log for ecs
resource "aws_cloudwatch_log_group" "this" {
  name = "this"

   tags = {
    Name = "${var.environment}-cloudwatch"
    Environment = var.environment
  }
}





