#hinrerith from the root terragrunt.hcl ( backend and locals) so we have the state on the production bucket and lock table.
#the hcl is also responsible to get the  production region and hcl locals.
include {
  path = find_in_parent_folders("terragrunt.hcl")
}

# get the basic lambda module
terraform {
    source = "../../../../../modules/lambda"  # path to my lambda generic architecture module without layers.
}

# path to my lambda code designed for production.
inputs = {
    lambda_source_path = "${path.module}/../../../../../src/lambda_code/lambda_function_test/lambda_function_prod.zip" 
    lambda_name = "lambda_function_prod"
}