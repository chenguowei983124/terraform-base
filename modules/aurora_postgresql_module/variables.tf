variable "cluster_identifier" {
  description = "The identifier for the Aurora cluster"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "master_username" {
  description = "The master username for the database"
  type        = string
}

variable "master_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "engine_version" {
  description = "The version of PostgreSQL to use"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the database"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "VPC security group IDs for the database"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Subnet IDs for the database"
  type        = list(string)
}

variable "scaling_min_capacity" {
  description = "Minimum capacity units for Aurora Serverless"
  type        = number
}

variable "scaling_max_capacity" {
  description = "Maximum capacity units for Aurora Serverless"
  type        = number
}

variable "db_port" {
  description = "The port for the database"
  type        = number
}

variable "instance_count" {
  description = "The number of instances"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
