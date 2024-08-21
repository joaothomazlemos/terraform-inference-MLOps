
data "aws_caller_identity" "current" {}
data "aws_ecr_authorization_token" "auth" {}



module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.lambda_name
  description   = var.lambda_image_description #"A Lambda image to test my knowledge"
  runtime       = "python3.10"


  create_package = false
  

  image_uri    = "${var.image_uri}@${var.image_digest}"
  package_type = "Image"


  

  create_role = true #create the default role.


  ######################
  # Additional policies
  ######################


  attach_policy_jsons = true
  policy_jsons = [
    data.aws_iam_policy_document.sns_policy.json,
    data.aws_iam_policy_document.ecr_policy.json
  ]
  number_of_policy_jsons = 2



}

