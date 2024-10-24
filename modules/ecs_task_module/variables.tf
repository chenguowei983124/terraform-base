variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "task_name" {
  description = "The name of the ECS task"
  type        = string
}

variable "container_image" {
  description = "The Docker image to use for the container"
  type        = string
}

variable "container_port" {
  description = "The port that the container will listen on"
  type        = number
}

variable "desired_count" {
  description = "The desired number of tasks"
  type        = number
  default     = 1
}

variable "subnets" {
  description = "The subnets to deploy the ECS service"
  type        = list(string)
}

variable "security_groups" {
  description = "The security groups to associate with the ECS service"
  type        = list(string)
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that allows ECS to pull containers"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the IAM role that the task can assume"
  type        = string
}
