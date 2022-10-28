variable "Dev_ec2" {
    type = string
}

# Creating Ubuntu EC2 server
resource "aws_instance" "ec2" {
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"

    tags = {
      Name = var.Dev_ec2
    }
}

output "Instance_id" {
    value = aws_instance.ec2.id
}