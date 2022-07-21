
#  Creates the network topology
module "networking" {
  source = "./modules/networking"
  # Passing the environment
  environment          = var.environment
  # Passing vpc_cidr
  vpc_cidr             = var.vpc_cidr
  # Passing Public subnet cidr AZ1
  public_subnet_cidr_AZ1  = var.public_subnet_cidr_AZ1
    # Passing Public subnet cidr AZ2
  public_subnet_cidr_AZ2  = var.public_subnet_cidr_AZ2
  # Passing Private subnet cidr
  private_subnet_cidr = var.private_subnet_cidr
}

# Reuse the code that creates ec2 instances in app subnet
module "ec2" {
  source = "./modules/ec2"
  # Creating ec2s with the names and numbers as we pass in the list, the last machine is configuration machine with public IP
  vm_names = ["ApplicationServer-1", "ConfigurationMachine"]
  # Passing the app subnetID, creating the machines in the right subnet
  public_subnet_id_az1 = module.networking.public_subnet_id_az1
  # Passing publickey for the machines
  public_key = var.public_key
  # Passing public security group
  public_security_group = module.networking.public_security_group
  # Passing the environment
  environment = var.environment

}

# Creates db in private subnet on ecs
module "ecs-db" {
  source = "./modules/ecs-db"
  # Passing the environment
  environment = var.environment
  # Passing the private subnet id
  private_subnet_id = module.networking.private_subnet_id
  # Passing the private security group
  private_security_group = module.networking.private_security_group
  # Passing publickey for the machine
  public_key = var.public_key
  # Passing the POSTGRES password for ecs container
  POSTGRES_PASSWORD = var.POSTGRES_PASSWORD
}
# Create app in public subnet on ecs
module "ecs-app" {
  source = "./modules/ecs-app"
   # Passing the environment
  environment = var.environment
   # Passing the public security group
  public_security_group = module.networking.public_security_group
   # Passing the public subnet id az1
  public_subnet_id_az1 = module.networking.public_subnet_id_az1
  # Passing the ecs target group
  ecs_target_group = module.loadbalancer.ecs_target_group
  # Passing loadbalancer dns name
  loadbalancer_dns = module.loadbalancer.elb_dns
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
# Creating load balancer for app-ecs
module "loadbalancer" {
  source = "./modules/loadbalancer"
  # Passing app security group
  public_security_group = module.networking.public_security_group
  # Passing 2 public subnets with different AZ
  public_subnet_id_az1 = module.networking.public_subnet_id_az1
  public_subnet_id_az2 = module.networking.public_subnet_id_az2
  # Passing vpc id
  vpc_id = module.networking.vpc_id
}
# Create auto scaling for app-ecs
module "auto_scaling" {
  source = "./modules/auto-scaling"
  # Passing app ecs cluster
  ecs_cluster_app = module.ecs-app.ecs_cluster_app
  # Passing app ecs service
  ecs_service_app = module.ecs-app.ecs_service_app
}
# Create roles and policies
module "iam" {
  source = "./modules/iam"
  # Passing load balancer
  elb = module.loadbalancer.elb
}