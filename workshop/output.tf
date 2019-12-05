output "vpc_id" {
  value = module.myvpc.vpc_id
}

output "plublic_subnet_id" {
  value = module.myvpc.plublic_subnet_id
}

output "private_subnet_id" {
  value = module.myvpc.private_subnet_id
}

output "first_ec2instance_dns" {
  value = module.myec2.first_ec2instance_dns
}

output "first_ec2instance_public_ip" {
  value = module.myec2.first_ec2instance_public_ip
}

output "second_ec2instance_dns" {
  value = module.myec2.second_ec2instance_dns
}

output "second_ec2instance_ip" {
  value = module.myec2.second_ec2instance_ip
}
