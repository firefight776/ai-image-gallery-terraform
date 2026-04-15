variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_zip_path" {
  description = "Path to the packaged Lambda zip file"
  type        = string
}

variable "upload_bucket_name" {
  description = "S3 bucket name for uploaded images"
  type        = string
}