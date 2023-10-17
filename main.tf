terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "lambda" {
  source = "./lambda-module"

# Input Variables
  s3_lambda_destination_bucket_name= "s3-lambda-destination-bucket"
  lambda_runtime = "python3.9"
  aws_region = "us-east-1"
  s3_lambda_trigger_bucket_name = "module-bucket-trigger"
}