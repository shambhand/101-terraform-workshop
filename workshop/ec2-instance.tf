resource "aws_key_pair" "ssh_key" {
  key_name = "anuj-workshop" // replace with your key
  public_key = "" // replace with you public IP
}

resource "aws_instance" "first_instance" {
  ami = "ami-04b9e92b5572fa0d1"

  subnet_id = aws_subnet.public_subnet_1.id

  key_name = aws_key_pair.ssh_key.key_name

  instance_type = "t2.micro"

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.ssh_port.id, aws_security_group.http.id]

  user_data = data.template_file.install_apache.rendered
}

resource "aws_instance" "second_instance" {
  ami = "ami-04b9e92b5572fa0d1"

  subnet_id = aws_subnet.public_subnet_1.id

  instance_type = "t2.micro"
}

resource "aws_security_group" "ssh_port" {
  vpc_id = aws_vpc.workshop.id

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"] // replace it with you IP
  }
}

resource "aws_security_group" "http" {
  vpc_id = aws_vpc.workshop.id

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
  template = file("install-apache.tpl")

  vars = {}
}