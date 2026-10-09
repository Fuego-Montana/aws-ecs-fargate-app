variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for Fargate tasks."
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "ALB security group ID (ingress source for tasks)."
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN."
  type        = string
}

variable "execution_role_arn" {
  description = "ECS task execution role ARN."
  type        = string
}

variable "task_role_arn" {
  description = "ECS task role ARN."
  type        = string
}

variable "container_image" {
  description = "Container image URI."
  type        = string
}

variable "container_port" {
  description = "Container port."
  type        = number
  default     = 8080
}

variable "task_cpu" {
  description = "Fargate CPU units."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Fargate memory MiB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired task count."
  type        = number
  default     = 1
}

variable "assign_public_ip" {
  description = "Assign public IP to tasks."
  type        = bool
  default     = false
}

variable "log_retention_days" {
  description = "CloudWatch log retention days."
  type        = number
  default     = 14
}

variable "aws_region" {
  description = "AWS region for log configuration."
  type        = string
}

variable "environment" {
  description = "Environment name passed to the container."
  type        = string
}
