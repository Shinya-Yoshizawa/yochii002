# Parent Account IBM Cloud Provider
provider ibm {
    region                = var.region
    ibmcloud_timeout      = 60
}

# Resource Group where VPC will be created
data ibm_resource_group "resource_group" {
  name = var.resource_group
}

# Create a VPC
resource ibm_is_vpc vpc {
  name           = var.vpc_name
  resource_group = data.ibm_resource_group.resource_group.id
  classic_access = var.classic_access
  default_security_group_name = var.default_security_group_name
  default_network_acl_name = var.default_acl_name
  default_routing_table_name = var.default_routing_table_name
  tags = var.tags
}

# Security Group Rules for ICMP
resource ibm_is_security_group_rule sg_rules_icmp {
  count     = length(var.sg_add_inbound_rules_icmp) 
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = var.sg_add_inbound_rules_icmp[count.index].remote
  icmp {
    type = var.sg_add_inbound_rules_icmp[count.index].type
    code = var.sg_add_inbound_rules_icmp[count.index].code
  }
}

# Security Group Rules for TCP
resource ibm_is_security_group_rule sg_rules_tcp {
  count     = length(var.sg_add_inbound_rules_tcp) 
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = var.sg_add_inbound_rules_tcp[count.index].remote
  tcp {
    port_min = var.sg_add_inbound_rules_tcp[count.index].port_min
    port_max = var.sg_add_inbound_rules_tcp[count.index].port_max
  }
}

# Security Group Rules for UDP
resource ibm_is_security_group_rule sg_rules_udp {
  count     = length(var.sg_add_inbound_rules_udp) 
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = var.sg_add_inbound_rules_udp[count.index].remote
  tcp {
    port_min = var.sg_add_inbound_rules_udp[count.index].port_min
    port_max = var.sg_add_inbound_rules_udp[count.index].port_max
  }
}


resource ibm_is_vpc_address_prefix vpc_address_prefix {
  count      = length(var.prefix-list) 
  name       = "${var.vpc_name}-prefix-${count.index}"
  zone       = var.prefix-list[count.index].zone
  vpc        = ibm_is_vpc.vpc.id
  cidr       = var.prefix-list[count.index].cidr
  is_default = var.prefix-list[count.index].default
}

# Subnet
resource ibm_is_subnet vpc_subnet_zone {
  count           = length(var.subnets) 
  vpc             = ibm_is_vpc.vpc.id
  resource_group  = data.ibm_resource_group.resource_group.id
  name            = var.subnets[count.index].name
  zone            = var.subnets[count.index].zone
  ipv4_cidr_block = var.subnets[count.index].cidr
}

