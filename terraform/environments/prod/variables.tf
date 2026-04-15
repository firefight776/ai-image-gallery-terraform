variable "project_name" {
  default = "ai-image-gallery"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}

variable "public_subnet_1a_cidr" {
  type = string
}

variable "public_subnet_1b_cidr" {
  type = string
}

variable "private_subnet_1a_cidr" {
  type = string
}

variable "private_subnet_1b_cidr" {
  type = string
}

variable "app_port" {
  description = "Application port"
  type        = number
}

variable "hosted_zone_name" {
  description = "Existing Route 53 hosted zone name"
  type        = string
}

variable "app_domain_name" {
  description = "Full DNS name for the application"
  type        = string
}

variable "uploads_bucket_name" {
  description = "S3 bucket name for uploaded images"
  type        = string
}

variable "alert_email" {
  description = "Email address for SNS alarm notifications"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the upload Lambda function"
  type        = string
}