# my lambda modules (with the functions)
module "test_lambda" {
  source = "terraform-aws-modules/lambda/aws"  # This is an example, replace with your actual module path
  function_name = var.lambda_name
  description   = "A Lambda function to test my knowledge"
  runtime       = "python3.10"

  # Use the input variable for the source path
  source_path   = var.lambda_source_path
}