# Region
variable "region" {
  type = string
  default = "jp-osa"
}

# VPC Name
variable "vpc_name" {
  type = string
  default = "dev-kd-jp-osa-vpc-01"
}

# Security Group
variable "default_security_group_name" {
  type = string
  default = "dev-kd-jp-osa-sg-default"
}

# Resource Group
variable "resource_group" {
    description = "Name of resource group where all infrastructure will be provisioned"
    type        = string
    default = "dev-customer-direct"
}

# Prefix
variable prefix {
    description = "A unique identifier need to provision resources. Must begin with a letter"
    type        = string
    default     = "dev-kd-jp-osa-vpc-prefix"
}

# Classic Access flag
variable classic_access {
  description = "Enable VPC Classic Access. Note: only one VPC per region can have classic access"
  type        = bool
  default     = false
}
