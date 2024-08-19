variable "lambda_name" {
  description = "The name of the lambda function"
  type        = string
  default     = "my-function"

}

variable "lambda_arn" {
  description = "The ARN of the lambda function"
  type        = string
  #random default value
  default     = "arn:aws:lambda:us-east-1:123456789012:function:my-function"

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