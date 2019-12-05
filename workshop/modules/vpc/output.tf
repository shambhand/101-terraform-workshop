output "vpc_id" {
  value = aws_vpc.workshop.id
}

output "plublic_subnet_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet_1.id
}
