module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  tags = {
    Name        = "eventbridge-rule-lambda-test"
    Environment = "prod"
  }
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
        input = jsonencode({ "job" : "cron-by-rate" })
      }
    ]
  }
}



#create the permission for the eventbridge rule to trigger the lambda
resource "aws_lambda_permission" "eventbridge_lambda_permission" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = module.eventbridge.eventbridge_rule_arns["crons"]
  depends_on = [ module.eventbridge ]
}

