provider "aws" {
    region = "eu-central-1"
}

# Creating ngix web server
resource "aws_instance" "WebServer" {
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.Nginx_SG.name]
    user_data = file("nginx_server.tpl")

    tags = {
      Name = "Web_Server"
    }
}

# Creating db server
resource "aws_instance" "DbServer" {
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"

    tags = {
      Name = "Db_Server"
    }
}

# Create an Elastic IP to for web server
resource "aws_eip" "webEIP" {
  instance = aws_instance.WebServer.id

  tags = {
    Name = "WebServer_EIP"
  }
}

# Create security groups
resource "aws_security_group" "Nginx_SG" {
  name = "Allow HTTPS"

    ingress {
        description = "SSH into my Web Server"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    }



    egress {
        description = "Allow inbound Traffic on port 443"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    }
}

# Retrieve the IP address of my Device
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

# Outputs
output "PrivateIP" {
    value = aws_instance.DbServer.private_ip
}

output "PublicIP" {
    value = aws_eip.webEIP.public_ip
}