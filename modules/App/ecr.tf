resource "aws_ecr_repository" "foo" {
  name = "app"

    tags = {
    Name = "${var.environment}-ecr-app"
    Environment = var.environment
  }
}
