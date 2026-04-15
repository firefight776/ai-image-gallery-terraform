output "alb_sg_id" {
  description = "Security group ID for the ALB"
  value       = aws_security_group.alb.id
}

output "ecs_service_sg_id" {
  description = "Security group ID for the ECS service"
  value       = aws_security_group.ecs_service.id
}