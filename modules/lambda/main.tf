# my lambda modules (with the functions)
data "archive_file" "lambda_package" {
  type        = "zip"
  source_dir  = var.lambda_source_path
  output_path = var.lambda_output_path
  
  
}

module "test_lambda" {
  source = "terraform-aws-modules/lambda/aws"  # This is an example, replace with your actual module path
  function_name = var.lambda_name
  description   = "A Lambda function to test my knowledge"
  runtime       = "python3.10"
  handler       = "lambda_function.lambda_handler"

  # Use the zip ( from outputh) variable for the source path in the module
  source_path   = var.lambda_output_path
}

