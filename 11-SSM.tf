#パラメータストア
module "ssm_parameters" {
  source = "./modules/ssm_parameters_module"

  parameters = {
    "sample1" = {
      name        = "sample1-name"
      description = "The database password"
      type        = "SecureString"
      value       = "sample1 value"
    },
    "sample2" = {
      name        = "sample2-name"
      description = "The API key for my application"
      type        = "String"
      value       = "sample2 value"
    }
  }

  overwrite = true

  tags = {
    Environment = "${var.env}"
  }
}