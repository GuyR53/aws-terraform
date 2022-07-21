variable "environment" {
  description = "The Deployment environment"
}

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

