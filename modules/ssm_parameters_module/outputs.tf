output "parameter_names" {
  description = "Names of the SSM parameters"
  value       = keys(aws_ssm_parameter.this)
}

output "parameter_arns" {
  description = "ARNs of the SSM parameters"
  value       = [for param in aws_ssm_parameter.this : param.arn]
}
