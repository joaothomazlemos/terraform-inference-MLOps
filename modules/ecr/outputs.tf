output "image_digest" {
  value = data.aws_ecr_image.lambda_image.image_digest
}

output "image_uri" {
  value = data.aws_ecr_image.lambda_image.image_uri
}