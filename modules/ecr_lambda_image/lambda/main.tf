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

  create_role = true # we need more than basic iam policy to work with ecr so we create our own role and policy
  # role_name = aws_iam_role.lambda_role.name
  # depends_on = [ aws_iam_role_policy_attachment.lambda_policy_attachment ]
  

}


#iam for this module to work properly on creating and also updating#############################################################################

# resource "aws_iam_role" "lambda_role" {
#   #name_prefix = "lambda_ecr_role_"
#   name = "lambda_ecr_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "lambda_policy" {
#   #name_prefix = "lambda_ecr_policy_"
#   name        = "lambda_ecr_policy"
#   description = "Policy for lambda function"
#   policy      = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:BatchGetImage",
#           "ecr:BatchCheckLayerAvailability"
#         ]
#         Resource = "*"
#       },
#       {
#         Effect = "Allow"
#         Action = "ecr:GetAuthorizationToken"
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
#   role       = aws_iam_role.lambda_role.name
#   policy_arn = aws_iam_policy.lambda_policy.arn
#   depends_on = [ aws_iam_policy.lambda_policy, aws_iam_role.lambda_role ]
# }

# #we need to name the role dinaamically to avoid conflicts in the future
# resource "random_id" "id" {
#   byte_length = 4
# }