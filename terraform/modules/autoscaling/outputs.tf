output "autoscaling_target_id" {
  description = "App Auto Scaling target resource ID."
  value       = aws_appautoscaling_target.ecs.resource_id
}

output "cpu_policy_arn" {
  description = "CPU target-tracking policy ARN."
  value       = aws_appautoscaling_policy.cpu.arn
}
