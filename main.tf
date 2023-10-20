terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
      configuration_aliases = [ aws.s3-provider]
    }
  }
}

### S3 outputs ###

output "s3_bucket_trigger_id" {
  value = module.s3.s3_bucket_trigger_id
  sensitive = true
}

output "s3_bucket_trigger_arn" {
  value = module.s3.s3_bucket_trigger_arn
  sensitive = true
}

### ECR outputs ###

output "aws_ecr_repository" {
  value = module.ecr.aws_ecr_repository
}

output "lambda_image_id" {
  value = module.ecr.lambda_image_id
  sensitive = true
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "s3" {
  source                        = "./modules/s3"
  s3_lambda_trigger_bucket_name = var.s3_lambda_trigger_bucket_name
}

module "ecr" {
  source = "./modules/ecr"
  lambda_path = var.lambda_path
  ecr_repo_name = var.ecr_repo
  ecr_image_tag = var.ecr_image_tag
  aws_region = var.aws_region
  username = var.username
}

module "lambda" {
  source         = "./modules/lambda"
  depends_on     = [module.ecr, module.s3]
  commit_sha     = var.commit_sha
  aws_ecr_repository = module.ecr.aws_ecr_repository
  lambda_image_id = module.ecr.lambda_image_id
  s3_trigger_id  = module.s3.s3_bucket_trigger_id
  s3_trigger_arn = module.s3.s3_bucket_trigger_arn
}