terraform {
  backend "s3" {
    encrypt = true
    bucket  = "terraform-parsi-test"
    key     = "remote-state-demo/terraform.tfstate"
    region  = "us-east-1"
  }
}