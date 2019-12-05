terraform {
  required_version = "0.12.17"

  backend "s3" {
    bucket = "ee-terraform-workshop"
    region = "us-east-1"
    key = "workshopstate/modules/terraform.tfstate"
  }
}

module "myvpc" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/24"
  public_subnet_1_cidr = "10.0.0.0/27"
  private_subnet_1_cidr = "10.0.0.32/27"

}

module "myec2" {
  source = "./modules/ec2"

  sshkeypath = "id_rsa.pub"  # before running change the content of this file with your ssh public key
  ami_id = "ami-04b9e92b5572fa0d1"
  vpc_id = module.myvpc.vpc_id
  plublic_subnet_id = module.myvpc.plublic_subnet_id
  instance_type = "t2.micro"

}
