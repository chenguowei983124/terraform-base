#data "aws_caller_identity" "current" {}

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.2.1"

  repository_name = "${var.APP_NAME}-${var.env}-etl-ecr"


  #repository_read_write_access_arns = [data.aws_caller_identity.current.arn]
  create_lifecycle_policy           = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 3 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 2
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  repository_force_delete = true

  tags = { Name = "${var.APP_NAME}-${var.env}--etl-ecr" }
}