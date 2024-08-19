#output the lambda arn and name
output "lambda_function_arn" {
  value = aws_lambda_function.lambda_function_container_image.arn
}



output "lambda_name" {
  value = aws_lambda_function.lambda_function_container_image.function_name
}

