variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/24"
}

variable "public_subnet_1_cidr" {
  default = "10.0.0.0/27"
}

variable "private_subnet_1_cidr" {
  default = "10.0.0.32/27"
}
