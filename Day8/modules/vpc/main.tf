resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "${var.project_name}-vpc"
    }

  
}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "${var.project_name}-igw"
    }

}

# resource "aws_subnet" "public_subnets" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = "10.0.0.0/24"
#     availability_zone = "ca-central-1"
#     map_public_ip_on_launch = true

#     tags = {
#       Name = "main_subnet_public"
#     }

  
# }
# Dynamic CIDR calculation example
resource "aws_subnet" "private_subnets" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index + 8)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
        Name = "${var.project_name}-public-${count.index}"
    }
}


# resource "aws_subnet" "private_subnets" {
#     vpc_id = aws_vpc.main.id
#     count  = 2
#     cidr_block = "10.0.2.0/24"
#     availability_zone = data.aws_availability_zones.available.names[count.index]
#     map_public_ip_on_launch = true
  
  
# }

resource "aws_route_table" "public"{
    vpc_id = aws_vpc.main.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "${var.project_name}-public-rt"
    }

}



# resource "aws_subnet" "private_subnets" {
#   count             = 2
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = cidrsubnet("10.0.0.0/16", 4, count.index + 2)
#   availability_zone = data.aws_availability_zones.available.names[count.index]

#   tags = {
#     Name = "${var.project_name}-private-${count.index}"
#   }
# }



# resource "aws_route_table_association" "public_assoc" {
#   count          = 2
#   subnet_id      = aws_subnet.public_subnets[count.index].id
#   route_table_id = aws_route_table.public.id
# }

# Create subnets with count
resource "aws_subnet" "public_subnets" {
  count             = 2
  vpc_id            = aws_vpc.main.id
#   availability_zone = "ca-central-1"
  map_public_ip_on_launch = true
  cidr_block        = "10.0.${1 + count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
}

# Associate all public subnets
resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}


# resource "aws_route_table_association" "public_assoc" {
#   count          = 2
#   subnet_id      = aws_subnet.public_subnets[*].id[count.index]
#   route_table_id = aws_route_table.public.id
# }


data "aws_availability_zones" "available" {}
