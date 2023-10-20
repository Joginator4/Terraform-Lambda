resource "aws_s3_bucket_notification" "lambda_notification" {
  bucket = var.s3_trigger_id
  lambda_function {
    lambda_function_arn = aws_lambda_function.process_settlement_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".json"
  }
}