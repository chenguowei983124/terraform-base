variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "policy_description" {
  description = "A description of the IAM policy"
  type        = string
  default     = "Managed by Terraform"
}

variable "policy_document" {
  description = "The IAM policy document (in JSON format)"
  type        = string
}
