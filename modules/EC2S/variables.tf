variable "vm_names" {
  type = list
  description = "List of machines to create with their names"
}

variable "public_subnet_id" {
  description = "public subnet id"
}

variable "public_key" {
  description = "the public key for the machines"
}

variable "public_security_group" {
  description = "public security group id"
}

variable "environment" {
  description = "type of environment"
}
