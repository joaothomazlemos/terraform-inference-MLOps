variable "account_id" {
  description = "The account id of the ECR repository"
  type        = string
}

variable "region" {
  description = "The region in which the ECR repository is created"
  type        = string
}

variable "env" {
  description = "The environment of the ECR repository"
  type        = string
  
}