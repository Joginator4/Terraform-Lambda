resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-store-statefile"
    force_destroy = false

}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket        = aws_s3_bucket.terraform_state.bucket 
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "terraform_webserver_bucket" {
  bucket = var.client-settlements
  force_destroy = true

  tags = {
    "Name" = "Client-Settlements"
  }
}
