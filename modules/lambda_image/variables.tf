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