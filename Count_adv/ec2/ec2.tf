variable "server_names" {
    type = list(string)
}

# Creating Ubuntu EC2 server
resource "aws_instance" "ec2" {
    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"
    count = length(var.server_names)

    tags = {
      Name = var.server_names[count.index]
    }
}

output "PrivateIP" {
    value = [aws_instance.ec2.*.private_ip]
}