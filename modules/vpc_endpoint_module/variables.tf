# variables.tf in vpc-endpoint-module

variable "vpc_id" {
  description = "The ID of the VPC in which the endpoint will be created"
  type        = string
}

variable "region" {
  description = "The AWS region where the VPC endpoint will be created"
  type        = string
  default     = "ap-northeast-1"
}

variable "service_name" {
  description = "The AWS service to which the endpoint will connect (e.g., s3, dynamodb)"
  type        = string
  
}

variable "vpc_endpoint_type" {
  description = "The type of the VPC endpoint (Gateway or Interface)"
  type        = string
  default     = "Interface"
}

variable "private_dns_enabled" {
  description = "Whether or not to enable private DNS for the VPC endpoint"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "The security group IDs to associate with the VPC endpoint, if it's an Interface type"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "The subnet IDs to associate with the VPC endpoint, if it's an Interface type"
  type        = list(string)
  default     = []
}

variable "route_table_ids" {
  description = "The route table IDs to associate with the VPC endpoint, if it's a Gateway type"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
