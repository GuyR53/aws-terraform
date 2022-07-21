# Getting the index of the configuration machine to make publicIPAddress
locals {
  MachinewithIP="${length(var.vm_names)-1}"
}