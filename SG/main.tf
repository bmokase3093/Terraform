provider "aws" {
    region = "eu-central-1"
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

  ingress {
    description = "Allow inbound Traffic on port 443"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  egress {
    description = "Allow outbound Traffic on port 443"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  tags = {
    "Name" = "Allow_443"
  }
    
}