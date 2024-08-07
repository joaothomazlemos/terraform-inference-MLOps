include {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform {
  source = "../../../../../modules/lambda_image"
}

inputs = {
  image_uri = "123456789012.dkr.ecr.us-east-1.amazonaws.com/lambda_image_test2"
  lambda_name = "lambda_function_image_test2_${local.environment}"
}




dependencies {
  paths = ["../../../../../modules/ecr"]
}
