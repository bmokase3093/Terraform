provider "aws" {
    region = "eu-central-1"
}

# setup the module
module "ec2module" {
    source = "./ec2"
    Dev_ec2 = "Name From Module"
}

# output of a module
output "module_output" {
    value = module.ec2module.Instance_id
}