variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "username" {
  type = string
}

variable "ecr_repo_name" {
  type    = string
}

variable "ecr_image_tag" {
  type    = string
}

variable "lambda_path" {
  type= string
}