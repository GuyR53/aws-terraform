resource "aws_ecs_task_definition" "this" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 2048
  memory                   = 4096
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "db",
    "image": "postgres:latest",
    "cpu": 2048,
    "memory": 4096,
    "essential": true,
    "containerPort": 5432,
    "hostPort": 5432
  }
]
TASK_DEFINITION


}