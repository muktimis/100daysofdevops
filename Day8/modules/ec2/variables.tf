# modules/ec2/variables.tf

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "user_data_path" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "key_name" {
  description = "Name of the EC2 Key Pair to use for SSH access"
  type        = string
}
