variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "acl" {
  description = "The ACL of the S3 bucket"
  type        = string
  default     = "private"
}

variable "versioning_status" {
  description = "The status of versioning"
  type        = string
  default     = "Disabled"
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use"
  type        = string
  default     = "AES256"
}
