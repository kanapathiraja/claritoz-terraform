
# provider.tf

# Specify the provider and access details
provider "aws" {
  region     = "us-west-2"
  access_key = secrets.AWS_KEY_ID
  secret_key = secrets.AWS_SECRETE_ID
}
