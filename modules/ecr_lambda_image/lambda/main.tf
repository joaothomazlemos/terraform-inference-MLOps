module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  description   = var.lambda_image_description #"A Lambda image to test my knowledge"
  runtime       = "python3.10"

  create_package = false

  image_uri    = "${var.image_uri}:${var.ecr_image_tag}" # when triggered, the lambda function will be updated with the new image ( same name , new sha256)
  package_type = "Image"

  # The image digest is used to trigger updates when the image changes: pull the latest image from the ECR repository
  environment_variables = {
    IMAGE_DIGEST = var.image_digest
  }


}

