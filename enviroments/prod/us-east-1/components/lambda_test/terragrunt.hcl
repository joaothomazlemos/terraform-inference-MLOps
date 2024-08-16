#hinrerith from the root terragrunt.hcl ( backend and locals) so we have the state on the production bucket and lock table.
#the hcl is also responsible to get the  production region and hcl locals.
include "commum env vars" {
  path = find_in_parent_folders("terragrunt.hcl")
}

# get the basic lambda module
terraform {
  source = "../../../../../modules/lambda_basic" # path to my lambda generic architecture module without layers.
}

# path to my lambda code designed for production.
inputs = {
  lambda_source_path = "${get_terragrunt_dir()}/../../../../../src/lambda_code/lambda_function_test/lambda_function_prod"
  lambda_output_path = "${get_terragrunt_dir()}/../../../../../src/lambda_code/lambda_function_test/lambda_function_prod/lambda_function.zip"
  lambda_name        = "lambda_function_test_prod"

}

