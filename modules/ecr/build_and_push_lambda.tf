data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "auth" {}

locals {
  repository_url = aws_ecr_repository.lambda_image_repository.repository_url # created on the aws_ecr_repository resource on this module, passed by the ecr component
  image_tag = "${var.ecr_image_tag}-${timestamp()}"
}

#var environment = could be prod or dev
#var image_source = the source of the image that is specified on the input of the hcl file.

resource "null_resource" "build_and_push_lambda" {
  provisioner "local-exec" {
    command = <<EOF
        aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${local.repository_url}
        docker build --platform linux/amd64 -t ${local.repository_url}:${var.ecr_image_tag} ${var.image_source}
        docker push ${local.repository_url}:${var.ecr_image_tag}
    EOF
    }

    # Add a trigger so that this resource is executed whenever the Dockerfile or other relevant files change
  triggers = {
    image_source = var.image_source
    environment = var.ecr_image_tag
  }
}
