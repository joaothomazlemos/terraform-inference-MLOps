
data "aws_caller_identity" "current" {}
data "aws_ecr_authorization_token" "auth" {}



module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  description   = var.lambda_image_description #"A Lambda image to test my knowledge"
  runtime       = "python3.10"


  create_package = false


  image_uri    = "${var.image_uri}:${var.ecr_image_tag}" # when triggered, the lambda function will be updated with the new image ( same name , new sha256)
  package_type = "Image"

  # The image digest is used to trigger updates when the image changes: pull the latest image from the ECR repository
  environment_variables = {
    IMAGE_DIGEST = var.image_digest
  }

  create_role = true #create the default role.
#   assume_role_policy_statements = {
#   iam_user_access = {
#     effect  = "Allow",
#     actions = ["sts:AssumeRole"],
#     principals = {
#       user_principal = {
#         type        = "AWS",
#         identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.iam_user_name}"]
#       }
#     }
   
#   }
# }
  # assume_role_policy_statements = [
  #   {
  #     effect  = "Allow"
  #     actions = ["sts:AssumeRole"]

  #     principals = [
  #       {
  #       type        = "Service"
  #       identifiers = ["lambda.amazonaws.com"]
  #       }
  #     ]
    
  #   }
  # ]
  # # depends_on = [ aws_iam_role_policy_attachment.lambda_policy_attachment ]
  # #only if create role is false, we define our policys, role and attach the policy to the role



  ######################
  # Additional policies
  ######################


  attach_policy_jsons = true
  policy_jsons = [
    data.aws_iam_policy_document.sns_policy.json,
    data.aws_iam_policy_document.ecr_policy.json
  ]
  number_of_policy_jsons = 2

  # attach_policy_statements = true
  # policy_statements = {
  #   sns_policy = {
  #     effect = "Allow"
  #     actions = ["sns:*"]
  #     resources = ["*"]
  #   }
  #   ecr_policy = {
  #     effect = "Allow"
  #     actions = ["ecr:*"]
  #     resources = ["*"]
  #   }
  # }

}
  