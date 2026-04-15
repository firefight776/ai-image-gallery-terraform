output "alb_5xx_alarm_name" {
  description = "ALB 5XX alarm name"
  value       = aws_cloudwatch_metric_alarm.alb_5xx.alarm_name
}

output "target_unhealthy_alarm_name" {
  description = "Unhealthy target alarm name"
  value       = aws_cloudwatch_metric_alarm.target_unhealthy.alarm_name
}

output "ecs_cpu_alarm_name" {
  description = "ECS CPU alarm name"
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_high.alarm_name
}

output "ecs_memory_alarm_name" {
  description = "ECS memory alarm name"
  value       = aws_cloudwatch_metric_alarm.ecs_memory_high.alarm_name
}
