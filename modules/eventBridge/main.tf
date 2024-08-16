module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus = false

  rules = {
    crons = {
      description         = var.eventbridge_description
      schedule_expression = var.schedule_expression
    }
  }

  targets = {
    crons = [
      {
        name  = var.lambda_name
        arn   = var.lambda_arn
        input = jsonencode({"job": "cron-by-rate"})
      }
    ]
  }
}