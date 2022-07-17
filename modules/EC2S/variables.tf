variable "vm_names" {
  type = list
  description = "List of machines to create with their names"
}


variable "public_subnet_id" {}

variable "public_key" {}

variable "public_security_group" {}

variable "environment" {}
# Getting the index of the configuration machine to make publicIPAddress
locals {
  MachinewithIP="${length(var.vm_names)-1}"
}