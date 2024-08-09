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
  image_uri = "${local.account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.ecr_repository_name}:${local.ecr_image_tag}"
}

inputs = {

  image_uri = local.image_uri
  lambda_name = "lambda_function_image_test2"
  image_digest = dependency.ecr_lambda_test2.outputs.image_digest # this is the output of the ecr_lambda_test2 module
                                                                  #everytime a new image is pushed to the ecr repository
                                                                  #this value will change and the lambda_image module will
                                                                  #be triggered to update the lambda function with the new image
}




dependencies {
  paths = ["../ecr_lambda_test2"]
}

