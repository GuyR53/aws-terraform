# ecs app cluster
resource "aws_ecs_cluster" "thisapp" {
  name = "${var.environment}-ecs-cluster-app"

  tags = {
    Name = "${var.environment}-ecs-cluster-app"
    Environment = var.environment
  }
}

# ecs app service
resource "aws_ecs_service" "this" {
  name            = "${var.environment}-ecs-service-app"
  cluster         = aws_ecs_cluster.thisapp.arn
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2
  launch_type = "FARGATE"


    network_configuration {
      assign_public_ip = true
      subnets = [var.public_subnet_id_az1]
      security_groups = [var.public_security_group]
  }
  load_balancer {
    target_group_arn = var.ecs_target_group.arn
    container_name = "app"
    container_port = 8080
  }


    tags = {
    Name = "${var.environment}-ecs-service-app"
    Environment = var.environment
  }
}

