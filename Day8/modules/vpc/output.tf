output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}


# output "public_subnet_ids" {
#   value = aws_subnet.public_subnets[*].id
# }

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "default_security_group_id" {
  value = aws_vpc.main.default_security_group_id
}