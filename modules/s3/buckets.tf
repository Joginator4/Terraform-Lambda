resource "aws_s3_bucket" "trigger-bucket" {
  bucket        = var.s3_lambda_trigger_bucket_name
  force_destroy = true

  tags = {
    "Name" = "Client-Settlements"
  }
}