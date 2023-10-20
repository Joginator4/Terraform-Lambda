resource "aws_ecr_repository" "repository_lambda" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "null_resource" "ecr_image_creation" {
  triggers = {
    docker_file  = md5(file("${var.lambda_path}/Dockerfile"))
    python_file  = md5(file("${var.lambda_path}/src/process_settlement.py"))
    requirements = md5(file("${var.lambda_path}/requirements.txt"))
  }

  provisioner "local-exec" {
    command = <<EOF
            aws ecr get-login-password --region ${var.aws_region} | docker login --username ${var.username} --password-stdin ${local.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com
            cd "${var.lambda_path}"
            docker build -t ${aws_ecr_repository.repository_lambda.repository_url}:${var.ecr_image_tag} .
            docker push ${aws_ecr_repository.repository_lambda.repository_url}:${var.ecr_image_tag}
        EOF
  }
}

data "aws_ecr_image" "lambda_image" {
  depends_on = [
    null_resource.ecr_image_creation
  ]
  repository_name = var.ecr_repo_name
  image_tag       = var.ecr_image_tag
}