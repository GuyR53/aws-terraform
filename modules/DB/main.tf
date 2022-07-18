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
  launch_type = "EC2"

    network_configuration {
    assign_public_ip = false
    subnets = [var.private_subnet_id]
    security_groups = [var.private_security_group]
  }


    tags = {
    Name = "${var.environment}-ecs-service"
    Environment = var.environment
  }
}


resource "aws_instance" "db_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  subnet_id = var.private_subnet_id
  security_groups = [var.private_security_group]
  key_name = "id_rsa"
  tags = {
    Name = "${var.environment}-db-ec2"
    Environment = var.environment
  }

    connection {
      type        = "ssh"
      user        = "ubuntu"
      timeout     = "1m"
   }
}
