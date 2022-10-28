provider "aws" {
    region = "eu-central-1" 
}

# create an rds instance
resource "aws_db_instance" "myrds" {
    db_name = "mydb"
    identifier = "myrds"
    instance_class = "db.t2.micro"
    engine = "MariaDB"
    engine_version = "10.6.10"
    username = "bongz"
    password = "password123"
    port = 3306
    allocated_storage = 20
    skip_final_snapshot = true
}