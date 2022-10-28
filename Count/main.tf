provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "UbuntuEC2" {
  ami = "ami-0caef02b518350c8b"
  instance_type = "t2.micro"
  count = 5
}