variable "aws_region"{
    default = "ca-central-1"
}

variable "project_name" {
    default = "scalable-webapp"
}

variable "key_name" {
  description = "The name of the EC2 Key Pair to use"
  type        = string
}


