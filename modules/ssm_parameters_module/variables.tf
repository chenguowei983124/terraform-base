variable "parameters" {
  description = "A map of parameters to create in SSM Parameter Store"
  type = map(object({
    name        = string
    description = string
    type        = string  # "String", "StringList", or "SecureString"
    value       = string
  }))
}

variable "overwrite" {
  description = "Whether to overwrite an existing parameter. Defaults to false."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
