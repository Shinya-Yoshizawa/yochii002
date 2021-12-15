variable "zone1" {
  default = "dev-kd-jp-osa-zone1"
}

variable "zone2" {
  default = "dev-kd-jp-osa-zone2"
}

variable "zone3" {
  default = "dev-kd-jp-osa-zone3"
}

variable "vpc_name" {
  default = "dev-kd-jp-osa-vpc-01"
}

variable "cidr1" {
  default = "10.248.0.0/18"
}

variable "resource_group" {
  default = "dev-costomer-direct"
}

variable "security_group" {
  default = "dev-kd-jp-osa-security_group-01"
}

variable "network_acl" {
  default = "dev-kd-jp-osa-network_acl-01"
}

variable "routing_table" {
  default = "dev-kd-jp-osa-routing_table-01"
}
