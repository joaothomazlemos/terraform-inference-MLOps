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



dependency "private_ecr" {
  config_path = "../ecr"
  mock_outputs = {
    private_repository_name       = "mock-repository-name"
    private_repository_arn        = "arn:aws:ecr:region:aws_account_id:repository/mock-repository-name"
    private_repository_registry_id = "mock-registry-id"
    private_repository_url        = "aws_account_id.dkr.ecr.region.amazonaws.com/mock-repository-name"
    private_image_digest          = "mock-image-digest"
  }
}




inputs = {
  #lambda module instance
  lambda_name = "lambda_function_test_2"
  lambda_image_description = "A Lambda image to test my knowledge"
  image_uri   = dependency.private_ecr.outputs.private_repository_url
  image_digest = dependency.private_ecr.outputs.private_image_digest
  ecr_image_tag = local.env

  
}

