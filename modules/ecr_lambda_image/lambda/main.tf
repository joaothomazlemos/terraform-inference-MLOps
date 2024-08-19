
# data "aws_caller_identity" "current" {}
# data "aws_ecr_authorization_token" "auth" {}

module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  description   = var.lambda_image_description #"A Lambda image to test my knowledge"
  runtime       = "python3.10"


  create_package = false

  #add the eventbridge trigger to the lambda module
  event_source_mapping = {
    event_bridge = {
      event_bus_arn = var.eventbridge_rule_arn
    }
  }





  image_uri    = "${var.image_uri}:${var.ecr_image_tag}" # when triggered, the lambda function will be updated with the new image ( same name , new sha256)
  package_type = "Image"

  # The image digest is used to trigger updates when the image changes: pull the latest image from the ECR repository
  environment_variables = {
    IMAGE_DIGEST = var.image_digest
  }

  create_role = true # we need more than basic iam policy to work with ecr so we create our own role and policy
  # role_name = aws_iam_role.lambda_role.name
  # depends_on = [ aws_iam_role_policy_attachment.lambda_policy_attachment ]
  #only if create role is false, we define our policys, role and attach the policy to the role



  ######################
  # Additional policies
  ######################


  attach_policy_jsons = true
  policy_jsons = [
    data.aws_iam_policy_document.sns_policy.json
  ]
  number_of_policy_jsons = 1

}

data "aws_iam_policy_document" "sns_policy" {
  statement {
    actions = [
      "sns:Publish",
      "sns:Subscribe",
      "sns:Unsubscribe",
      "sns:ListSubscriptionsByTopic",
      "sns:ListSubscriptions",
      "sns:ListTopics",
      "sns:GetTopicAttributes",
      "sns:GetSubscriptionAttributes",
      "sns:ConfirmSubscription",
      "sns:CreateTopic",
      "sns:DeleteTopic",
      "sns:SetTopicAttributes",
      "sns:SetSubscriptionAttributes",
      "sns:AddPermission",
      "sns:RemovePermission",
      "sns:Receive",
      "sns:DeleteEndpoint",
      "sns:CreatePlatformEndpoint",
      "sns:CheckIfPhoneNumberIsOptedOut",
      "sns:CheckIfPhoneNumberIsOptedOut",
      "sns:ConfirmSubscription",
      "sns:CreatePlatformApplication",
      "sns:CreatePlatformEndpoint",
      "sns:CreateTopic",
      "sns:DeleteEndpoint",
      "sns:DeletePlatformApplication",
      "sns:DeletePlatformEndpoint",
      "sns:DeleteTopic",
      "sns:GetEndpointAttributes",
      "sns:GetPlatformApplicationAttributes",
      "sns:GetSMSAttributes",
      "sns:GetSubscriptionAttributes",
      "sns:GetTopicAttributes",
      "sns:ListEndpointsByPlatformApplication",
      "sns:ListPhoneNumbersOptedOut",
      "sns:ListPlatformApplications",
      "sns:ListSubscriptions",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTagsForResource",
      "sns:ListTopics",
      "sns:OptInPhoneNumber",
      "sns:Publish",
      "sns:RemovePermission",
      "sns:SetEndpointAttributes",
      "sns:SetPlatformApplicationAttributes",
      "sns:SetSMSAttributes",
      "sns:SetSubscriptionAttributes",
      "sns:SetTopicAttributes",
      "sns:Subscribe",
      "sns:TagResource",
      "sns:Unsubscribe"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

}