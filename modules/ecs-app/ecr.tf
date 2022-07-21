# ecr repository
resource "aws_ecr_repository" "app" {
  name = "app"

    tags = {
    Name = "${var.environment}-ecr-app"
    Environment = var.environment
  }
}
