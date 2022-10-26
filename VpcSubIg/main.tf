provider "aws" {
    region = "eu-central-1"
}

# Create a VPC, name, CIDR and Tags
resource "aws_vpc" "dev_VPC" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"

    tags = {
        Name = "dev"
    }
}

# create Public Subnet
resource "aws_subnet" "dev-Public-sub" {
    vpc_id = aws_vpc.dev_VPC.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1b"

    tags = {
        Name = "dev-public-sub"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "dev-igw" {
    vpc_id = aws_vpc.dev_VPC.id

    tags = {
      Name = "dev-igw"
    }
}

# Create Route Tables for my Internet Gateway
resource "aws_route_table" "dev-public-routeT" {
    vpc_id = aws_vpc.dev_VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev-igw.id
    }

    tags = {
        Name = "dev-public-routeT"
    }
}

# Creating Route association
resource "aws_route_table_association" "dev-public" {
    subnet_id = aws_subnet.dev-Public-sub.id
    route_table_id = aws_route_table.dev-public-routeT.id
}