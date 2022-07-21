variable "environment" {
  description = "enironment"
}
variable "public_subnet_id_az1" {
  description = "public subnet az1"
}
variable "public_security_group" {
  description = "public security group"
}
variable "ecs_target_group" {
  description = "target group for lb"
}
variable "loadbalancer_dns" {}

# .env parameters:
variable "PORT" {
  description = "port"
}
variable "HOST" {
  description = "host"
}
variable "PGHOST" {
  description = "db ip"
}
variable "PGUSERNAME" {
  description = "db username"
}
variable "PGDATABASE" {
  description = "db name"
}
variable "PGPASSWORD" {
  description = "db password"
}
variable "PGPORT" {
  description = "db port"
}
variable "HOST_URL" {
  description = "host url"
}
variable "COOKIE_ENCRYPT_PWD" {
  description = "cookie encryption"
}
variable "NODE_ENV" {
  description = "environment"
}
variable "OKTA_ORG_URL" {
  description = "okta url"
}
variable "OKTA_CLIENT_ID" {
  description = "okta client id"
}
variable "OKTA_CLIENT_SECRET" {
  description = "okta secret"
}
