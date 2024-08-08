include {
    path = find_in_parent_folders("terragrunt.hcl")
}

terraform {
  source = "../../../../../modules/ecr"
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  aws_region  = local.region_vars.locals.aws_region
  terraform_dir = get_terragrunt_dir()
  image_source = "${local.terraform_dir}/../../../../../src/lambda_code/lambda_function_test_2/lambda_function_test_2_prod"
}

inputs = {
  ecr_repository_name = "ecr_lambda_test2"
  ecr_image_tag = "prod"
  region = local.aws_region
  image_source = local.image_source # the code of the lambda function to dockerize
  #image_source = "../../../../../src/lambda_code/lambda_function_test_2_prod"
}