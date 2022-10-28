provider "aws" {
    region = "eu-central-1"
}

module "ec2" {
    source = "./ec2"
    server_names = ["mariadb", "mysql", "mssql"]
}

output "private_ips" {
    value = module.ec2.PrivateIP
  
}