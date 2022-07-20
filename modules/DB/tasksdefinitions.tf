# Task to run the db by fargate
resource "aws_ecs_task_definition" "this" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "db",
    "image": "postgres:latest",
    "awslogs-create-group": "true",
    "cpu": 512,
    "memory": 1024,
    "essential": true,
    "environment": [
                {
                    "name": "POSTGRES_PASSWORD",
                    "value": "${var.POSTGRES_PASSWORD}"

                }
            ],
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


# cloudwatch_log for the task
resource "aws_cloudwatch_log_group" "this" {
  name = "this"

   tags = {
    Name = "${var.environment}-cloudwatch-db"
    Environment = var.environment
  }
}

# Execution role for task logs
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}