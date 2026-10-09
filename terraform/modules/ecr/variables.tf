variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
}

variable "keep_images" {
  description = "Number of tagged images to retain."
  type        = number
  default     = 10
}
