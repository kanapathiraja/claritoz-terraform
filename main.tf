terraform {
  backend "s3" {
    bucket = "claritoz-terraform-poc"
    key    = "claritoz-terraform-poc/terraform.tfstate"
    region = "us-west-2"
  }
}


