### BACKEND ###

variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "s3_bucket_remote_state" {
  default = "terraform-store-lambda-statefile-module"
  type = string
}

### LAMBDA ###


variable "s3_lambda_trigger_bucket_name" {
  default = "s3-lambda-trigger-buckettt"
  type    = string
}

variable "s3_lambda_destination_bucket_name" {
  default = "s3-lambda-destination-bucket"
  type    = string
}

variable "lambda_arn" {
  default = "arn:aws:lambda:us-east-1:410040632229:function:process_settlement"
  type    = string
}

variable "lambda_handler" {
  default = "process_settlement.lambda_handler"
  type    = string
}

variable "lambda_runtime" {
  default = "python3.9"
  type    = string
}

#sensitive = true  , for password to avoid echo on terminal