### LAMBDA ###
variable "commit_sha" {
  type    = string
}

### S3 ###

variable "s3_trigger_id" {}

variable "s3_trigger_arn" {}

### ECR ###

variable "aws_ecr_repository" {}

variable "lambda_image_id" {}


