# resource "aws_s3_bucket" "terraform_state" {
#   bucket        = var.s3_bucket_remote_state
#   force_destroy = false

# }

# resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
#   bucket = aws_s3_bucket.terraform_state.bucket
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

resource "aws_s3_bucket" "trigger-bucket" {
  bucket        = var.s3_lambda_trigger_bucket_name
  force_destroy = true

  tags = {
    "Name" = "Client-Settlements"
  }
}

resource "aws_s3_bucket" "lambda-destination-bucket" {
  bucket        = var.s3_lambda_destination_bucket_name
  force_destroy = true

  tags = {
    "Name" = "lambda_bucket"
  }
}

resource "null_resource" "wait_for_lambda_trigger" {
  depends_on = [aws_lambda_function.process_settlement_lambda]
  provisioner "local-exec" {
    command = "sleep 2m"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket     = aws_s3_bucket.trigger-bucket.id
  depends_on = [null_resource.wait_for_lambda_trigger]
  lambda_function {
    lambda_function_arn = aws_lambda_function.process_settlement_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".json"
  }
}