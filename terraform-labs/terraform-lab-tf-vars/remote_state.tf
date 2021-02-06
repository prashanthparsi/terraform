terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-parsi-test"
    region         = "us-east-1"
    # dynamodb_table = "terraform-state"
  }
}