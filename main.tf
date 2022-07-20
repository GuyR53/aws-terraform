
#  Creates the network topology
module "Networking" {
  source = "./modules/networking"
  # Passing the environment
  environment          = var.environment
  # Passing vpc_cidr
  vpc_cidr             = var.vpc_cidr
  # Passing Public subnet cidr
  public_subnet_cidr  = var.public_subnet_cidr
  # Passing Private subnet cidr
  private_subnet_cidr = var.private_subnet_cidr
}

# Reuse the code that creates ec2 instances in app subnet
module "EC2S" {
  source = "./modules/EC2S"
  # Creating ec2s with the names and numbers as we pass in the list, the last machine is configuration machine with public IP
  vm_names = ["ApplicationServer-1", "ConfigurationMachine"]
  # Passing the app subnetID, creating the machines in the right subnet
  public_subnet_id = module.Networking.public_subnet_id
  # Passing publickey for the machines
  public_key = var.public_key
  # Passing public security group
  public_security_group = module.Networking.public_security_group
  # Passing the environment
  environment = var.environment

}

# Creates db in private subnet on ecs container
module "DB" {
  source = "./modules/DB"
  # Passing the environment
  environment = var.environment
  # Passing the private subnet id
  private_subnet_id = module.Networking.private_subnet_id
  # Passing the private security group
  private_security_group = module.Networking.private_security_group
  # Passing publickey for the machine
  public_key = var.public_key
  # Passing the POSTGRES password for ecs container
  POSTGRES_PASSWORD = var.POSTGRES_PASSWORD
}

module "App" {
  source = "./modules/App"
   # Passing the environment
  environment = var.environment
   # Passing the public security group
  public_security_group = module.Networking.public_security_group
   # Passing the public subnet id
  public_subnet_id = module.Networking.public_subnet_id
  # .env parameters:

  PORT = var.PORT
  HOST = var.HOST
  PGHOST = var.PGHOST
  PGUSERNAME = var.PGUSERNAME
  PGDATABASE = var.PGDATABASE
  PGPASSWORD = var.PGPASSWORD
  PGPORT = var.PGPORT
  HOST_URL = var.HOST_URL
  COOKIE_ENCRYPT_PWD = var.COOKIE_ENCRYPT_PWD
  NODE_ENV = var.NODE_ENV
  OKTA_ORG_URL = var.OKTA_ORG_URL
  OKTA_CLIENT_ID = var.OKTA_CLIENT_ID
  OKTA_CLIENT_SECRET = var.OKTA_CLIENT_SECRET

}