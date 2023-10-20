data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_function/src/${local.lambda_name}.py"
  output_path = "${local.lambda_name}.zip"
}

resource "aws_lambda_function" "process_settlement_lambda" {
  function_name    = local.lambda_name
  role             = aws_iam_role.iam_for_lambda.arn
  runtime          = var.lambda_runtime
  handler          = var.lambda_handler
  memory_size      = 128
  timeout          = 300
  source_code_hash = data.archive_file.lambda.output_base64sha256
  filename         = "${local.lambda_name}.zip"
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExectuionFromS3"
  source_arn    = aws_s3_bucket.trigger-bucket.arn
  function_name = aws_lambda_function.process_settlement_lambda.arn
  action        = "lambda:InvokeFunction"
  principal     = "s3.amazonaws.com"
}