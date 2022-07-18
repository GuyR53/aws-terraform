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

    network_configuration {
    subnets = [var.private_subnet_id]
    security_groups = [var.private_security_group]
  }


    tags = {
    Name = "${var.environment}-ecs-service"
    Environment = var.environment
  }
}


resource "aws_instance" "db_server" {
  ami           = "ami-0d70546e43a941d70"
  instance_type = "t2.micro"
  subnet_id = var.private_subnet_id
  security_groups = [var.private_security_group]
  key_name = "id_rsa"
  tags = {
    Name = "${var.environment}-db-ec2"
    Environment = var.environment
  }



}
