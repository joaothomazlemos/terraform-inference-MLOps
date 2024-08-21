#outputs the arn
output "eventbridge_rule_arn" {
  value = module.eventbridge.eventbridge_rule_arns["crons"]
}