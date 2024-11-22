variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "ECS name"
  type        = string
}

variable "cpu" {
  description = "CPU units"
  type        = string
}

variable "memory" {
  description = "Memory size "
  type        = string
}

variable "container_definitions" {
  description = "Container definitions"
  type        = string
}

variable "desired_count" {
  description = "desired task instances"
  type        = number
}

variable "subnets" {
  description = "Subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group"
  type        = string
}

variable "assign_public_ip" {
  description = "public IP"
  type        = bool
}
