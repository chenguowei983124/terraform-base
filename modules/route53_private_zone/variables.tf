variable "zone_name" {
  description = "The name of the private Route 53 hosted zone."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to associate with this private hosted zone."
  type        = string
}

variable "comment" {
  description = "A comment for the hosted zone."
  type        = string
  default     = "Private hosted zone"
}

variable "records" {
  description = "Map of DNS records with their details (name, type, ttl, and record value)."
  type = map(object({
    name   = string
    type   = string
    ttl    = number
    record = string
  }))
}
