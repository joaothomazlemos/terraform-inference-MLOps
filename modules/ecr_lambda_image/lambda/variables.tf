variable "lambda_name" {
  description = "The name of the Lambda function"
  type        = string

}

variable "image_uri" {
  description = "The URI of the Docker image"
  type        = string

}

variable "image_digest" {
  description = "The digest of the Docker image"
  type        = string

}

variable "lambda_image_description" {
  description = "The description of the lambda image"
  type        = string
}

variable "ecr_image_tag" {
  description = "The tag of the Docker image"
  type        = string

}
