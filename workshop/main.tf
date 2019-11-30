terraform {
  required_version = "0.12.16"

  backend "s3" {
    bucket = "ee-terraform-workshop"
    region = "us-east-1"
    key = "workshopstate/terraform.tfstate"
  }
}
