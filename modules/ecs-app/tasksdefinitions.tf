# Task to run the app by fargate
resource "aws_ecs_task_definition" "this" {
  family                   = "app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role_app.arn}"
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "app",
    "image": "896438603105.dkr.ecr.us-west-2.amazonaws.com/app:latest",
    "awslogs-create-group": "true",
    "cpu": 512,
    "memory": 1024,
    "essential": true,
    "environment": [
                {
                    "name": "OKTA_CLIENT_SECRET",
                    "value": "${var.OKTA_CLIENT_SECRET}"
                },
                {
                   "name": "HOST",
                   "value": "${var.HOST}"
                },
                {
                    "name": "PGHOST",
                    "value": "${var.PGHOST}"
                }, {
                    "name": "PORT",
                    "value": "${var.PORT}"
                } ,{
                    "name": "PGUSERNAME",
                    "value": "${var.PGUSERNAME}"
                },{
                    "name": "PGDATABASE",
                    "value": "${var.PGDATABASE}"
                },{
                    "name": "PGPASSWORD",
                    "value": "${var.PGPASSWORD}"
                },{
                    "name": "PGPORT",
                    "value": "${var.PGPORT}"
                },{
                    "name": "HOST_URL",
                    "value": "http://${var.loadbalancer_dns}:8080"
                },{
                    "name": "COOKIE_ENCRYPT_PWD",
                    "value": "${var.COOKIE_ENCRYPT_PWD}"
                },{
                    "name": "NODE_ENV",
                    "value": "${var.NODE_ENV}"
                },{
                    "name": "OKTA_ORG_URL",
                    "value": "${var.OKTA_ORG_URL}"
                },{
                    "name": "OKTA_CLIENT_ID",
                    "value": "${var.OKTA_CLIENT_ID}"
                }

            ],
    "networkMode": "awsvpc",
      "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "this_app",
                    "awslogs-region": "us-west-2",
                    "awslogs-stream-prefix": "nginx"
                }
            },
    "portMappings": [
        {
          "hostPort": 8080,
          "protocol": "tcp",
          "containerPort": 8080
        }
      ]
  }
]
TASK_DEFINITION

}


# cloudwatch_log for the task
resource "aws_cloudwatch_log_group" "this_app" {
  name = "this_app"

   tags = {
    Name = "${var.environment}-cloudwatch-app"
    Environment = var.environment
  }
}

# Execution role for task logs
data "aws_iam_role" "ecs_task_execution_role_app" {
  name = "ecsTaskExecutionRole"
}