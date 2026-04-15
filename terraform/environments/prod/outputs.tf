output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "upload_lambda_function_url" {
  description = "Function URL for the upload Lambda"
  value       = module.lambda.function_url
}