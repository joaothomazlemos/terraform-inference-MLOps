#output the lambda arn and name
output "lambda_arn" {
  value = module.lambda_function_container_image.lambda_function_arn
}

output "lambda_name" {
  value = module.lambda_function_container_image.lambda_function_name
}

