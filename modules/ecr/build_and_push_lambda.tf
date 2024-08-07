data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "auth" {}

locals {
  repository_url = aws_ecr_repository.lambda_image_repository.repository_url
  image_tag = "${var.environment}-${timestamp()}"
}

#var environment = could be prod or dev
#var image_source = the source of the image that is specified on the input of the hcl file.

resource "null_resource" "build_and_push_lambda" {
  provisioner "local-exec" {
    command = <<EOF
        aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${local.repository_url}
        docker build --platform linux/amd64 -t ${local.repository_url}:${var.environment} ${var.image_source}
        docker push ${local.repository_url}:${var.environment}
    EOF
    }

    # Add a trigger so that this resource is executed whenever the Dockerfile or other relevant files change
  triggers = {
    image_source = var.image_source
    environment = var.environment
  }
}

