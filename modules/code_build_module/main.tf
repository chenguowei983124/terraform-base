resource "aws_ecr_repository_policy" "example" {
  repository = aws_ecr_repository.example.name
  policy     = data.aws_iam_policy_document.example.json
}

data "aws_iam_policy_document" "example" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com",
      ]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}
resource "aws_codebuild_project" "ec2_managedimage" {
  name         = "ssss"
  service_role = aws_iam_role.codebuild_ec2_managedimage.arn

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    type            = "LINUX_CONTAINER"
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    privileged_mode = "true"
  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.codebuild.name
    }
  }

  cache {
    type = "LOCAL"
    modes = [
      "LOCAL_CUSTOM_CACHE",
    ]
  }
}
resource "aws_iam_role_policy" "codebuild_ec2_managedimage" {
  role   = aws_iam_role.codebuild_ec2_managedimage.id
  policy = data.aws_iam_policy_document.codebuild_custom_ec2_managedimage.json
}

data "aws_iam_policy_document" "codebuild_custom_ec2_managedimage" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.codebuild.arn}:*",
    ]
  }
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.example.arn}/*",
    ]
  }
}
