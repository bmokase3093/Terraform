provider "aws" {
    region = "eu-central-1"
}

variable "number_of_servers" {
  type = number
}

resource "aws_instance" "UbuntuEC2" {
  ami = "ami-0caef02b518350c8b"
  instance_type = "t2.micro"
  count = var.number_of_servers
}