variable "secret_key" {
  default = ""
  description = "secret key authentication"
}
variable "access_key" {
  default = ""
  description = "access key authentication"
}


variable "region" {
  description = "us-west-2"
  default = "us-west-2"
}

variable "environment" {
  description = "The Deployment environment"
  default = "Test"
}

//networking
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "The CIDR block of the vpc"
}

variable "public_subnet_cidr_AZ1" {
  default    = "10.0.1.0/24"
  description = "The CIDR block for the public subnet AZ1"
}

variable "public_subnet_cidr_AZ2" {
  default    = "10.0.2.0/24"
  description = "The CIDR block for the public subnet AZ2"
}

variable "private_subnet_cidr" {
  default =  "10.0.10.0/24"
  description = "The CIDR block for the private subnet"
}

variable "public_key" {
  default = ""
  description = "pubkey that we create for the machines"
}
# root password for docker ecs container's initiating
variable "POSTGRES_PASSWORD" {
  default = ""
  description = "password for postgres db container on ecs"
}
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