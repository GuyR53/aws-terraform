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

//Networking
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "The CIDR block of the vpc"
}

variable "public_subnet_cidr" {
  default    = "10.0.1.0/24"
  description = "The CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  default =  "10.0.10.0/24"
  description = "The CIDR block for the private subnet"
}

variable "public_key" {
  default = ""
  description = "pubkey that we create for the machines"
}

variable "POSTGRES_PASSWORD" {
  default = ""
  description = "password for postgres db container on ecs"
}