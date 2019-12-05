variable "region" {
  default = "us-east-1"
}

variable "sshkeypath" {
  default = ""
}

variable "ami_id" {
  default = "ami-04b9e92b5572fa0d1"
}

variable "vpc_id" {
  default = ""
}


variable "plublic_subnet_id" {
  default = ""
}


variable "instance_type" {
  default = "t2.micro"
}
