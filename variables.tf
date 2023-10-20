### GITLAB ###

variable "commit_sha" {
  type        = string
  description = "Commit SHA Gitlab CI/CD"
}

### AWS_GENERAL ###

variable "aws_region" {
  type    = string
}

### BACKEND ###

variable "s3_bucket_remote_state" {
  type    = string
}

### S3 ###

variable "s3_lambda_trigger_bucket_name" {
  type    = string
}

### ECR ###

variable "ecr_repo" {
  type = string
}

variable "username" {
  type = string
}

variable "ecr_image_tag" {
  type    = string
}

### LAMBDA ###

variable "lambda_path" {
  type = string
}