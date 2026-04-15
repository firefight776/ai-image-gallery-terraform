variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security groups"
  type        = string
}

variable "app_port" {
  description = "Application port exposed by the container"
  type        = number
  default     = 80
}