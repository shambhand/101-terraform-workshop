resource "aws_key_pair" "ssh_key" {
  key_name = "anuj-workshop" // replace with your key
  public_key = file("${var.sshkeypath}") // replace with you public key
}

resource "aws_instance" "first_instance" {
  ami = var.ami_id

  subnet_id = var.plublic_subnet_id

  key_name = aws_key_pair.ssh_key.key_name

  instance_type = var.instance_type

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.ssh_port.id, aws_security_group.http.id]

  user_data = data.template_file.install_apache.rendered
}

resource "aws_instance" "second_instance" {
  ami = var.ami_id

  subnet_id = var.plublic_subnet_id

  instance_type = var.instance_type
}

resource "aws_security_group" "ssh_port" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"] // replace it with you IP
  }
}

resource "aws_security_group" "http" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

data "template_file" "install_apache" {
  template = file("${path.module}/install-apache.tpl")

  vars = {}
}
