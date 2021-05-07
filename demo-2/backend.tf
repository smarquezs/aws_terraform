terraform {
  backend "s3" {
    bucket = "terraform-state-asdf01"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}