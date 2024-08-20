

#policy creation ########################################
data "aws_iam_policy_document" "sns_policy" {
  statement {
    actions = [
      "sns:*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

}

data "aws_iam_policy_document" "ecr_policy" {
  statement {
    actions = [
      "ecr:*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

#policies attachment ########################################


# resource "aws_iam_role" "lambda_role" {
#   name               = "iam_for_lambda"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
# }

# #ecr acess policy
# resource "aws_iam_policy" "ecr_access_policy" {
#   name        = "lambda__ecr_policy"
#   description = "Policy for lambda to access ECR"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "ecr:*"
#         ],
#         Resource = "*"
#       }
#     ]
#   })
# }

# #sns full acess policy
# resource "aws_iam_policy" "sns_access_policy" {
#   name        = "lambda_sns_policy"
#   description = "Policy for lambda to access SNS"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "sns:*"
#         ],
#         Resource = "*"
#       }
#     ]
#   })
# }

# #log group policy

# resource "aws_iam_policy" "log_group_policy" {
#   name        = "lambda_log_group_policy"
#   description = "Policy for lambda to access cloudwatch log group"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ],
#         Resource = ["arn:aws:logs:*:*:*"]
#       }
#     ]
#   })

# }

# #attach policies to role
# resource "aws_iam_role_policy_attachment" "ecr_access_policy_attachment" {
#   role       = aws_iam_role.lambda_role.name
#   policy_arn = aws_iam_policy.ecr_access_policy.arn
# }

# resource "aws_iam_role_policy_attachment" "sns_access_policy_attachment" {
#   role       = aws_iam_role.lambda_role.name
#   policy_arn = aws_iam_policy.sns_access_policy.arn
# }

# resource "aws_iam_role_policy_attachment" "log_group_policy_attachment" {
#   role       = aws_iam_role.lambda_role.name
#   policy_arn = aws_iam_policy.log_group_policy.arn
# }