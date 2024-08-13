# output "image_digest" {
#   value = data.aws_ecr_image.lambda_image.image_digest
# }

# output "image_uri" {
#   value = data.aws_ecr_image.lambda_image.image_uri
# }


################################################################################
# Public Repository
################################################################################

output "public_repository_name" {
  description = "Name of the repository"
  value       = module.public_ecr.repository_name
}

output "public_repository_arn" {
  description = "Full ARN of the repository"
  value       = module.public_ecr.repository_arn
}

output "public_repository_registry_id" {
  description = "The registry ID where the repository was created"
  value       = module.public_ecr.repository_registry_id
}

output "public_repository_url" {
  description = "The URL of the repository (in the form `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`)"
  value       = module.public_ecr.repository_url
}