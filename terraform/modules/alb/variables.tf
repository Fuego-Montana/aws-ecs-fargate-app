variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB."
  type        = list(string)
}

variable "container_port" {
  description = "Container port for the target group."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "Health check path."
  type        = string
  default     = "/health"
}
