################################################################################
# ECR Registry
################################################################################

data "aws_iam_policy_document" "ecr_policy" {
  statement {


    
    actions   = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:SetRepositoryPolicy",
      "ecr:GetRepositoryPolicy"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}