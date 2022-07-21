# ecs instances
resource "aws_instance" "app_server" {
  count = length(var.vm_names)
  ami           = "ami-0d70546e43a941d70"
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id_az1
  security_groups = [var.public_security_group]
  key_name = "id_rsa"
  # Last machine on the list have PublicIP
  associate_public_ip_address = count.index == local.MachinewithIP
  tags = {
    Name = "${var.vm_names[count.index]}"
    Environment = var.environment
  }



}
# ssh public key
resource "aws_key_pair" "deployer" {
  key_name   = "id_rsa"
  public_key = var.public_key
}
