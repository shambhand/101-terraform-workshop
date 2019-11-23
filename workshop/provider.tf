terraform {
  required_version = "0.12.16"
}

variable "aws_accesskey" {
  type = "string"
  default = ""
}

variable "aws_secretkey" {
  type = "string"
  default = ""
}

variable region {
  type = "string"
  default = "us-east-1"
}

provider "aws" {
  region = var.region
  access_key = var.aws_accesskey
  secret_key = var.aws_secretkey
}

