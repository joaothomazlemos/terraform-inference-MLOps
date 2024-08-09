output "image_digest" {
  value = data.docker_registry_image.lambda_image.digest
}