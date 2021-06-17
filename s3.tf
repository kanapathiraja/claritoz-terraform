resource "aws_s3_bucket" "b" {
  bucket = var.bucketname
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  
  
}