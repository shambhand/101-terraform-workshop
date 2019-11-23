resource "aws_key_pair" "ssh_key" {
  key_name = ""
  public_key = ""
}

resource "aws_instance" "first_instance" {
  ami = ""

  subnet_id = ""

  key_name = aws_key_pair.ssh_key.key_name

  instance_type = "t2.micro"

  associate_public_ip_address = true
}