data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_s3_bucket" "raw_existing" {
  bucket = var.raw_bucket_name
}

