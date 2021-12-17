# Region
variable "region" {
  type = string
  default = "jp-osa"
}

# IBM Cloud API KEY
variable "ibmcloud_api_key" {
  type = string
  default = ""
}

# VPC Name
variable "vpc_name" {
  type = string
  default = "dev-kd-jp-osa-vpc-01"
}

# Resource Group
variable resource_group {
    description = "Name of resource group where all infrastructure will be provisioned"
    type        = string
    default = "dev-costomer-direct"
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

# Use Public Gateway
variable use_public_gateways {
  description = "Create a public gateway in any of the three zones with `true`."
  type        = object({
    zone-1 = optional(bool)
    zone-2 = optional(bool)
    zone-3 = optional(bool)
  })
  default     = {
    zone-1 = true
    zone-2 = true
    zone-3 = true
  }
}

# Subnets
variable subnets {
  description = "List of subnets for the vpc. For each item in each array, a subnet will be created."
  type        = object({
    zone-1 = list(object({
      name           = string
      cidr           = string
      public_gateway = optional(bool)
    }))
    zone-2 = list(object({
      name           = string
      cidr           = string
      public_gateway = optional(bool)
    }))
    zone-3 = list(object({
      name           = string
      cidr           = string
      public_gateway = optional(bool)
    }))
  })
  default = {
    zone-1 = [
      {
        name           = "dev-kd-jp-osa-zone1"
        cidr           = "10.10.10.0/24"
        public_gateway = true
      }
    ],
    zone-2 = [
      {
        name           = "dev-kd-jp-osa-zone2"
        cidr           = "10.20.10.0/24"
        public_gateway = true
      }
    ],
    zone-3 = [
      {
        name           = "dev-kd-jp-osa-zone3"
        cidr           = "10.30.10.0/24"
        public_gateway = true
      }
    ]
  }
}

variable acl_rules {
  description = "Access control list rule set"
  type        = list(
    object({
      name        = string
      action      = string
      destination = string
      direction   = string
      source      = string
      tcp         = optional(
        object({
          port_max        = optional(number)
          port_min        = optional(number)
          source_port_max = optional(number)
          source_port_min = optional(number)
        })
      )
      udp         = optional(
        object({
          port_max        = optional(number)
          port_min        = optional(number)
          source_port_max = optional(number)
          source_port_min = optional(number)
        })
      )
      icmp        = optional(
        object({
          type = optional(number)
          code = optional(number)
        })
      )
    })
  )
  
  default     = [
    {
      name        = "allow-all-inbound"
      action      = "allow"
      direction   = "inbound"
      destination = "0.0.0.0/0"
      source      = "0.0.0.0/0"
    },
    {
      name        = "allow-all-outbound"
      action      = "allow"
      direction   = "outbound"
      destination = "0.0.0.0/0"
      source      = "0.0.0.0/0"
    }
  ]
}

# Security Groups
variable security_group_rules {
  description = "A list of security group rules to be added to the default vpc security group"
  type        = list(
    object({
      name        = string
      direction   = string
      remote      = string
      tcp         = optional(
        object({
          port_max = optional(number)
          port_min = optional(number)
        })
      )
      udp         = optional(
        object({
          port_max = optional(number)
          port_min = optional(number)
        })
      )
      icmp        = optional(
        object({
          type = optional(number)
          code = optional(number)
        })
      )
    })
  )

  default = [
    {
      name      = "allow-inbound-ping"
      direction = "inbound"
      remote    = "0.0.0.0/0"
      icmp      = {
        type = 8
      }
    },
    {
      name      = "allow-inbound-ssh"
      direction = "inbound"
      remote    = "0.0.0.0/0"
      tcp       = {
        port_min = 22
        port_max = 22
      }
    },
  ]
}

