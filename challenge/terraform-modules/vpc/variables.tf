variable "region" {
  description = "AWS region"
  type        = string
}

variable "name" {
  description = "VPN name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR"
  type        = string
}

variable "public_subnets" {
  description = "public subnet"
  type        = map(string)
}

variable "private_subnets" {
  description = "private subnet"
  type        = map(string)
}
