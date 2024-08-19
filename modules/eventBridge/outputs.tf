#outputs the arn
output "eventbridge_rule_arn" {
  value = module.eventBridge.eventbridge_rule_arn
}