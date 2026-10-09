variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name."
  type        = string
}

variable "service_name" {
  description = "ECS service name."
  type        = string
}

variable "min_capacity" {
  description = "Minimum number of tasks."
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of tasks."
  type        = number
  default     = 4
}

variable "cpu_target_value" {
  description = "Target average CPU utilization percent."
  type        = number
  default     = 70
}
