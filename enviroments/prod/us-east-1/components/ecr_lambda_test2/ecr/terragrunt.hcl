
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../../modules/ecr_lambda_image/ecr"
}

locals {
  region_vars    = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars   = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env_vars       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  aws_region     = local.region_vars.locals.aws_region
  aws_account_id = local.account_vars.locals.aws_account_id
  env            = local.env_vars.locals.environment
  image_source   = "../../../../../../src/lambda_code/lambda_function_test_2/lambda_function_test_2_${local.env}"
}

inputs = {
  #ecr module instance
  ecr_repository_name = "ecr_lambda_test2"
  image_source        = local.image_source
  account_id          = local.aws_account_id
  region              = local.aws_region
  ecr_image_tag       = local.env
  
  
}

