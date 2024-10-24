# locals {
#   flow_logs_to_cw_logs = true
#   flow_logs_to_s3      = true
#   flow_logs_s3_arn = module.audit_log_bucket[0].this_bucket.arn
# }
# data "aws_iam_policy_document" "flow_logs_publisher_assume_role_policy" {
#   count = local.flow_logs_to_cw_logs ? 1 : 0

#   statement {
#     principals {
#       type        = "Service"
#       identifiers = ["vpc-flow-logs.amazonaws.com"]
#     }
#     actions = ["sts:AssumeRole"]
#   }
# }
# resource "aws_iam_role" "flow_logs_publisher" {
#   count = local.flow_logs_to_cw_logs ? 1 : 0

#   name               = var.vpc_iam_role_name
#   assume_role_policy = data.aws_iam_policy_document.flow_logs_publisher_assume_role_policy[0].json

#   permissions_boundary = var.permissions_boundary_arn

#   tags = var.tags
# }
# data "aws_iam_policy_document" "flow_logs_publish_policy" {

#   statement {
#     actions = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#       "logs:DescribeLogGroups",
#       "logs:DescribeLogStreams"
#     ]
#     resources = ["*"]
#   }
# }