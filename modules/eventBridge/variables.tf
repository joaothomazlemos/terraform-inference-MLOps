variable "lambda_name" {
  description = "The name of the lambda function"
  type        = string

}

variable "lambda_arn" {
  description = "The ARN of the lambda function"
  type        = string

}

variable "eventbridge_description" {
  description = "The description of the eventbridge"
  type        = string
  default     = "EventBridge"

}

variable "schedule_expression" {
  description = "The schedule expression for the event rule"
  type        = string


}