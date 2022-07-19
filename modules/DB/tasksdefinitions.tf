# Task to run the db by fargate
resource "aws_ecs_task_definition" "this" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 4096
  memory                   = 8192
  execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "db",
    "image": "postgres:latest",
    "awslogs-create-group": "true",
    "cpu": 4096,
    "memory": 8192,
    "essential": true,
    "networkMode": "awsvpc",
      "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "this",
                    "awslogs-region": "us-west-2",
                    "awslogs-stream-prefix": "nginx"
                }
            },
    "portMappings": [
        {
          "hostPort": 5432,
          "protocol": "tcp",
          "containerPort": 5432
        }
      ]
  }
]
TASK_DEFINITION


}
# Execution role for fargate logs
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}