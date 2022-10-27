provider "aws" {
    region = "eu-central-1"
}

# Varibales to use
variable "ingressrules" {
  type = list(number)
  default = [80, 443]
}

variable "egressrules" {
  type = list(number)
  default = [80, 443, 25, 3306, 8080]
}

# Creating Ubuntu EC2 server
resource "aws_instance" "UbuntuEC2" {
  ami = "ami-0caef02b518350c8b"
  instance_type = "t2.micro"

  # link security group
  security_groups = [aws_security_group.webtraffic.name]

  tags = {
    Name = "Dev_Server"
  }
}

# Retrieve the IP address of my Device
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

# Create security groups
resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    }
  }

  tags = {
    "Name" = "Allowed_Ports"
  }
}