resource "aws_db_instance" "example" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "exampledb"
  username             = "admin"
  password             = "securepassword"
  skip_final_snapshot  = true

  # ✅ Must match VPC
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
#   db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [module.vpc.default_security_group_id]  # This must be from the same VPC
  publicly_accessible    = false

  tags = {
    Name = "example-rds"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    "subnet-021b2ed6f4de290de",
    "subnet-079267ac592762dd3",
    "subnet-0bc3438573132a1de"
  ]

  tags = {
    Name = "RDS Subnet Group"
  }
}

