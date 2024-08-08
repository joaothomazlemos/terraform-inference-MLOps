include {
  path = find_in_parent_folders("terragrunt.hcl")

}

terraform {
  source = "../../../../../modules/lambda_image"
}

locals {
  ecr_repository_name = "ecr_lambda_test2"
  ecr_image_tag = "prod"
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region = local.region_vars.locals.aws_region
  account_id = local.account_vars.locals.aws_account_id
}

inputs = {

  image_uri = "${local.account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.ecr_repository_name}:${local.ecr_image_tag}"
  lambda_name = "lambda_function_image_test2"
}




dependencies {
  paths = ["../ecr_lambda_test2"]
}

