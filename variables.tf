### BACKEND ###

variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "s3_bucket_remote_state" {
  default = "terraform-store-lambda-statefile-module"
  type = string
}