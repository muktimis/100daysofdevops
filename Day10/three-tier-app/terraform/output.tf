output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "internet_gateway_id" {
  value = module.vpc.igw_id
}

output "nat_gateway_ids" {
  value = module.vpc.natgw_ids
}

output "nat_gateway_ips" {
  value = module.vpc.nat_public_ips
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.name
}

