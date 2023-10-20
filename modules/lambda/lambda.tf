resource "aws_lambda_function" "process_settlement_lambda" {
  function_name    = local.lambda_name
  role             = aws_iam_role.iam_for_lambda.arn
  memory_size      = 128
  timeout          = 300
  architectures    = ["x86_64"]
  image_uri        = "${var.aws_ecr_repository}@${var.lambda_image_id}"
  package_type     = "Image"
  source_code_hash = var.commit_sha
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExectuionFromS3"
  source_arn    = var.s3_trigger_arn
  function_name = aws_lambda_function.process_settlement_lambda.arn
  action        = "lambda:InvokeFunction"
  principal     = "s3.amazonaws.com"
}