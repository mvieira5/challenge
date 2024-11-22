variable "region" {
  description = "AWS region"
  type        = string
}

variable "name" {
  description = "ALB name"
  type        = string
}

variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "subnets" {
  description = "subnets"
  type        = list(string)
}

variable "target_group_port" {
  description = "Port"
  type        = number
}

variable "target_group_protocol" {
  description = "Protocol"
  type        = string
}

variable "health_check_path" {
  description = "Path for health checks"
  type        = string
}

variable "enable_deletion_protection" {
  description = "enable deletion protection on the ALB"
  type        = bool
  default     = false
}
