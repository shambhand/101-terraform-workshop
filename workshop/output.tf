output "vpc_id" {
  value = aws_vpc.workshop.id
}

output "first_ec2instance_dns" {
  value = aws_instance.first_instance.public_dns
}

output "first_ec2instance_public_ip" {
  value = aws_instance.first_instance.public_ip
}

output "second_ec2instance_dns" {
  value = aws_instance.second_instance.private_dns
}

output "second_ec2instance_ip" {
  value = aws_instance.second_instance.private_ip
}