# ecs db cluster
resource "aws_ecs_cluster" "this" {
  name = "${var.environment}-ecs-cluster-db"

  tags = {
    Name = "${var.environment}-ecs-cluster-db"
    Environment = var.environment
  }
}

# ecs db service
resource "aws_ecs_service" "this" {
  name            = "${var.environment}-ecs-service-db"
  cluster         = aws_ecs_cluster.this.arn
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type = "FARGATE"


    network_configuration {
      subnets = [var.private_subnet_id]
      security_groups = [var.private_security_group]
  }


    tags = {
    Name = "${var.environment}-ecs-service-db"
    Environment = var.environment
  }
}







