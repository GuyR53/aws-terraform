variable "environment" {}
variable "public_subnet_id" {}
variable "public_security_group" {}
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