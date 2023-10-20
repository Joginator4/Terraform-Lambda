data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "lambda_settlement_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    sid    = "AllowInvokeLambda"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = ["lambda:InvokeFunction"]
  }

  statement {
    sid    = "AllowAllOnS3"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = ["s3:*", "s3-object-lambda:*"]
  }

  statement {
    sid    = "AllowAllOnCloudwatch"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = ["logs:*"]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda_iam_policy"
  policy = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.iam_for_lambda.name
}
