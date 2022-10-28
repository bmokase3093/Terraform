# save my state files in s3
terraform {
    backend "s3"{
        bucket = "s3terrafstatefiles"
        key = "terraform/tfstate.tfstate"
        region = "eu-central-1"
    }
}