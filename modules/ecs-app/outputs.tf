# ecs app cluster
output "ecs_cluster_app" {
  value = aws_ecs_cluster.thisapp
}
# ecs app service
output "ecs_service_app" {
  value = aws_ecs_service.this
}