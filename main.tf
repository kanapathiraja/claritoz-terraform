terraform {
  backend "s3" {
    bucket = "claritoz-terraform-poc"
    key    = "claritoz-terraform-poc/terraform.tfstate"
    region = "us-west-2"
  }
}

## random provider
provider "random" {}

## Provider us-east-1
provider "aws" {
  region = "us-east-1"
}
