variable "ecr_repository_name" {
    description = "The name of the ECR repository"
    type        = string
}

variable "region" {
    description = "The region in which the ECR repository is created"
    type        = string
  
}

variable "environment" {
    description = "The environment in which the ECR repository is created"
    type        = string
  
}

variable "image_source" {
    description = "The source of the image"
    type        = string
  
}