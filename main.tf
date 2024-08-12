
locals {
  image_source = "./src/lambda_code/lambda_function_test_2/lambda_function_test_2_prod"
}

# Example ECR to contain Lambda image
module "lambda_ecr" {
  source              = "./modules/ecr"
  account_id          = var.account_id
  ecr_repository_name = "ecr_lambda_test2"
  ecr_image_tag       = "prod"
  region              = var.region
  image_source        = local.image_source
}

# Example Lambda function deployed using ECR image
module "lambda_function" {
  source       = "./modules/lambda_image"
  lambda_name  = "lambda_function_image_test2"
  image_uri    = module.lambda_ecr.image_uri
  image_digest = module.lambda_ecr.image_digest

  depends_on = [module.lambda_ecr]
}
