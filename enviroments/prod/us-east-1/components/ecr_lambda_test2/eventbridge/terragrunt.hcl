
include "commum env vars" {

  path = find_in_parent_folders()
}

terraform { # where my module is located
  source = "../../../../../../modules/eventBridge"
}

locals {
  region_vars    = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars   = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env_vars       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  aws_region     = local.region_vars.locals.aws_region
  aws_account_id = local.account_vars.locals.aws_account_id
  env            = local.env_vars.locals.environment
}

inputs = {
  #eventbridge instance
  lambda_name             = dependency.lambda_function.outputs.lambda_name
  lambda_arn              = dependency.lambda_function.outputs.lambda_arn
  eventbridge_description = "trigger the lambda every few minutes, is testing"
  schedule_expression     = "rate(5 minute)"


}

dependency "lambda_function" { # the name of the module does not matter, just the main.tf file
  config_path = "../lambda"
  mock_outputs = {
    lambda_name = "mock-lambda-name"
    lambda_arn  = "arn:aws:lambda:us-east-1:123456789012:function:mock-lambda-name"

  }
}

