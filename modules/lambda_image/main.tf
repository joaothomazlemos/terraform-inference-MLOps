module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  description   = "A Lambda image to test my knowledge"

  create_package = false

  image_uri    = var.image_uri
  package_type = "Image"
}