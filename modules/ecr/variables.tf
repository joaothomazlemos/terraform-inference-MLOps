variable "ecr_repository_name" {
    description = "The name of the ECR repository"
    type        = string
}

variable "ecr_image_tag" {
    description = "The tag of the ECR repository"
    type        = string
  
}

variable "region" {
    description = "The region in which the ECR repository is created"
    type        = string
}

variable "account_id" {
    description = "The account id of the ECR repository"
    type        = string
  
}

variable "image_source" {
    description = "The source code of the image"
    type        = string
}