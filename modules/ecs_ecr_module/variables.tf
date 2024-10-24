# variables.tf

variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Valid values are MUTABLE or IMMUTABLE."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "enable_lifecycle_policy" {
  description = "Whether to enable a lifecycle policy for the ECR repository."
  type        = bool
  default     = false
}

variable "lifecycle_policy_file" {
  description = "Path to the file containing the ECR lifecycle policy."
  type        = string
  default     = ""
}

variable "retention_count" {
  description = "The number of images to retain in the lifecycle policy."
  type        = number
  default     = 10
}
