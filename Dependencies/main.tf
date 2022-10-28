provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "UbuntuEC2" {
  ami = "ami-0caef02b518350c8b"
  instance_type = "t2.micro"
}

resource "aws_instance" "web" {
    ami = "ami-06148e0e81e5187c8"
    instance_type = "t2.micro"

    depends_on = [
      aws_instance.UbuntuEC2
    ]
}