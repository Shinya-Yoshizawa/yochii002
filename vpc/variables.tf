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

# Resource Group Name
variable "resource_group" {
    description = "Name of resource group where all infrastructure will be provisioned"
    type        = string
    default = "dev-customer-direct"
}

# Prefix Name
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

# Security Group Inbound Rules for ICMP
variable sg_add_inbound_rules_icmp {
    type        = list(map(string))
    default     = [
      {
        remote = "0.0.0.0/0"
        type = "8"
        code = "0"
      }
    ]
    description = "When typing, paste from the text. A line feed code is required. remote : Source network. type : Icmp type. code : Icmp code."
}

# Security Group Inbound Rules for TCP
variable sg_add_inbound_rules_tcp {
    type        = list(map(string))
    default     = [
      {
        remote = "0.0.0.0/0"
        port_min = "22"
        port_max = "22"
      }
    ]
    description = "When typing, paste from the text. A line feed code is required. remote : Source network. port_min : Minimum port value. port_max : Maximum port value."
}

# Security Group Inbound Rules for UDP
variable sg_add_inbound_rules_udp {
    type        = list(map(string))
    default     = []
    description = "When typing, paste from the text. A line feed code is required. remote : Source network. port_min : Minimum port value. port_max : Maximum port value."
}


# Prefix
variable prefix-list {
    type        = list(map(string))
    default     = []
#    default     = [
#      {
#        zone = "jp-osa-1"
#        cidr = "10.248.0.0/18"
#        default = "false"
#      },
#      {
#        zone = "jp-osa-2"
#        cidr = "10.248.64.0/18"
#        default = "false"
#      },
#      {
#        zone = "jp-osa-3"
#        cidr = "10.248.128.0/18"
#        default = "false"
#      }
#    ]
    description = "When typing, paste from the text. A line feed code is required. zone : Zone name. cidr : Cidr. default : true or false."
}

# Subnet
variable subnets {
    type        = list(map(string))
    default     = [
      {
        "name" = "dev-kd-jp-osa-vpc-subnet11"
        "zone" = "jp-osa-1"
        "cidr" = "10.248.1.0/24"
      },
      {
        "name" = "dev-kd-jp-osa-vpc-subnet12"
        "zone" = "jp-osa-2"
        "cidr" = "10.248.65.0/24"
      },
      {
        "name" = "dev-kd-jp-osa-vpc-subnet13"
        "zone" = "jp-osa-3"
        "cidr" = "10.248.129.0/24"
      },
      {
        "name" = "dev-kd-jp-osa-vpc-subnet21"
        "zone" = "jp-osa-1"
        "cidr" = "10.248.2.0/24"
      },
      {
        "name" = "dev-kd-jp-osa-vpc-subnet22"
        "zone" = "jp-osa-2"
        "cidr" = "10.248.66.0/24"
      },
      {
        "name" = "dev-kd-jp-osa-vpc-subnet23"
        "zone" = "jp-osa-3"
        "cidr" = "10.248.130.0/24"
      }
    ]
    description = "When typing, paste from the text. A line feed code is required. name : Subnet name. zone : Zone name. cidr : Cidr."
}
