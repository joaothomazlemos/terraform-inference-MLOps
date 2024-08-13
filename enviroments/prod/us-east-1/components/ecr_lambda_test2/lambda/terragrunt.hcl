include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../../modules/ecr_lambda_image/lambda"
}
#source of the dependency ecr module:  "../../../../../../modules/ecr_lambda_image/ecr"

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
  #lambda module instance
  lambda_name = "lambda_function_test_2"
  lambda_image_description = "A Lambda image to test my knowledge"
  image_uri   = module.public_ecr.public_repository_url
  image_digest = module.public_ecr.image_digest
  
  
   
}

dependency "public_ecr" {
  config_path = find_in_parent_folders("ecr/terragrunt.hcl")
}