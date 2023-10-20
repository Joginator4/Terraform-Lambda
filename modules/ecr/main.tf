data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

output "account_ID" {
  value = data.aws_caller_identity.current.account_id
}


output "aws_ecr_repository" {
  value = aws_ecr_repository.repository_lambda.repository_url
}

output "lambda_image_id" {
  value = data.aws_ecr_image.lambda_image.id
}