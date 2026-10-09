variable "aws_region" {
  description = "AWS region to deploy into (ap-southeast-2 for Perth/WA)."
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Name prefix for all resources."
  type        = string
  default     = "fargate-app"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of dev, staging, prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "container_image" {
  description = <<-EOT
    Full container image URI (e.g. ACCOUNT.dkr.ecr.REGION.amazonaws.com/repo:tag).
    Leave empty on first plan to use Amazon's public sample; replace with your ECR
    image after the first docker build/push (see README).
  EOT
  type        = string
  default     = ""
}

variable "container_port" {
  description = "Port the container listens on."
  type        = number
  default     = 8080
}

variable "task_cpu" {
  description = "Fargate task CPU units (256 = 0.25 vCPU)."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired number of ECS tasks."
  type        = number
  default     = 1
}

variable "min_capacity" {
  description = "Autoscaling minimum task count."
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Autoscaling maximum task count."
  type        = number
  default     = 4
}

variable "cpu_target_percent" {
  description = "Target average CPU utilization for autoscaling."
  type        = number
  default     = 70
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days."
  type        = number
  default     = 14
}

variable "ecr_keep_images" {
  description = "Number of tagged images to retain in ECR."
  type        = number
  default     = 10
}

variable "assign_public_ip" {
  description = "Assign public IPs to tasks (false = private subnets + NAT)."
  type        = bool
  default     = false
}
