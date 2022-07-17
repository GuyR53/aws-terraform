resource "aws_instance" "app_server" {
  count = length(var.vm_names)
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  security_groups = [var.public_security_group]
  key_name = "id_rsa"
  # Last machine on the list doesn't have PublicIP
  associate_public_ip_address = count.index != local.MachinewithIP
  tags = {
    Name = "${var.vm_names[count.index]}"
    Environment = var.environment
  }

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      timeout     = "1m"
   }
}

resource "aws_key_pair" "deployer" {
  key_name   = "id_rsa"
  public_key = var.public_key
}
