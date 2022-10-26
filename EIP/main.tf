provider "aws" {
    region = "eu-central-1"
}

# Creating Ubuntu EC2 server
resource "aws_instance" "UbuntuEC2" {

  ami = "ami-0caef02b518350c8b"
  instance_type = "t2.micro"

  tags = {
    Name = "Dev_Server"
  }
}

# Create an Elastic IP for our EC2
resource "aws_eip" "elasticeip" {
  instance = aws_instance.UbuntuEC2.id

  tags = {
    Name = "Dev_EIP"
  }
}

# Output the elastic ip address
output "EIP" {
  value = aws_eip.elasticeip.public_ip
}