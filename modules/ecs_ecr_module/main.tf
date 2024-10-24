# main.tf

resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags
}

# Optionally, create a lifecycle policy for the ECR repository
resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy     = data.template_file.lifecycle_policy.rendered

  count = var.enable_lifecycle_policy ? 1 : 0
}

# Data source to load the lifecycle policy from a template file
data "template_file" "lifecycle_policy" {
  template = file(var.lifecycle_policy_file)

  vars = {
    retention_count = var.retention_count
  }
}
