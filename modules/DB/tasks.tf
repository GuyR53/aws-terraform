resource "aws_ecs_task_definition" "this" {
 container_definitions= jsonencode([
    {
      name      = "db"
      image     = "postgres:latest"
      cpu       = 216
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 5432
          hostPort      = 5432
        }
      ]
    }
  ])
family = "service"
network_mode = "awsvpc"
}