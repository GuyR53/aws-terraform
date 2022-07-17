variable "secret_key" {
  default = ""
  description = "secret key authentication"
}
variable "access_key" {
  default = ""
  description = "access key authentication"
}

variable "AWS_REGION" {
  default = "ap-south-1"
}
variable "region" {
  description = "us-east-1"
  default = "us-east-1"
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

