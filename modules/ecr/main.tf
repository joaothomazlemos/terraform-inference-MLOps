resource "aws_ecr_repository" "lambda_image_repository" {
  name = var.ecr_repository_name # this aks your tu input the name of the repository url
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}