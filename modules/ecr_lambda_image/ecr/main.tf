# resource "aws_ecr_repository" "lambda_image_repository" {
#   name                 = var.ecr_repository_name # this asks you to input the name of the repository
#   image_tag_mutability = "MUTABLE"
#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }

# locals {
#     image_tag      = var.ecr_image_tag
# }



module "private_ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_image_scan_on_push = true
  repository_image_tag_mutability = "MUTABLE"

  repository_name = var.ecr_repository_name
  repository_type = "private"
  repository_read_write_access_arns = [data.aws_caller_identity.current.arn]
  repository_force_delete = true
  create_lifecycle_policy = true
  repository_lifecycle_policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep the last 15 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 15
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
  
  tags = {
    Terraform   = "true"
    Environment = var.ecr_image_tag
  }
}




