# Tags
variable "tags" {
  type = list(string) 
  default = ["kd-kankyo"]
  description = "Enter any tags that you want to associate with your VPC. Tags might help you find your VPC more easily after it is created. Separate multiple tags with a comma (,)."
}

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

# Default Security Group Name
variable "default_security_group_name" {
  type = string
  default = "dev-kd-jp-osa-sg-default"
}

# Default ACL Name
variable "default_acl_name" {
  type = string
  default = "dev-kd-jp-osa-acl-default"
}

# Default Routing Table Name
variable "default_routing_table_name" {
  type = string
  default = "dev-kd-jp-osa-routing-default"
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

# ZONE1 PREFIX
variable create_zone1_prefix {
    type        = bool
    default     = false
}
variable zone1_cidr {
    type        = string
    default     = "10.248.0.0/18"
}

# ZONE2 PREFIX
variable create_zone2_prefix {
    type        = bool
    default     = false
}
variable zone2_cidr {
    type        = string
    default     = "10.248.64.0/18"
}

# ZONE3 PREFIX
variable create_zone3_prefix {
    type        = bool
    default     = false
}
variable zone3_cidr {
    type        = string
    default     = "10.248.128.0/18"
}

# ZONE1 Subnet
variable subnet {
    type        = list(map(name = string, zone = string, cidr = string))
    default     = [
      {
        "name" = "subnet1"
        "zone" = "jp-osa-1"
        "cidr" = "10.248.1.0/24"
      },
      {
        "name" = "subnet2"
        "zone" = "jp-osa-2"
        "cidr" = "10.248.65.0/24"
      },
      {
        "name" = "subnet3"
        "zone" = "jp-osa-3"
        "cidr" = "10.248.129.0/24"
      },
    ]
}
