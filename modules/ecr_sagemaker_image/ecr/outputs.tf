# output "image_digest" {
#   value = data.aws_ecr_image.lambda_image.image_digest
# }

# output "image_uri" {
#   value = data.aws_ecr_image.lambda_image.image_uri
# }


################################################################################
# private Repository
################################################################################

output "private_repository_name" {
  description = "Name of the repository"
  value       = module.private_ecr.repository_name
}

output "private_repository_arn" {
  description = "Full ARN of the repository"
  value       = module.private_ecr.repository_arn
}

output "private_repository_registry_id" {
  description = "The registry ID where the repository was created"
  value       = module.private_ecr.repository_registry_id
}

output "private_repository_url" {
  description = "The URL of the repository (in the form `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`)"
  value       = module.private_ecr.repository_url
}

output "private_image_digest" {
  description = "The image digest that identifies the image in the repository"
  value       = data.aws_ecr_image.latest_image.image_digest
}


output "private_combined_hash" {
  description = "The combined hash of all the files in the image source directory"
  value       = local.combined_hash
}
