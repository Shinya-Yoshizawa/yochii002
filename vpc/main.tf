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

# Default Security Group Rule
#resource ibm_is_security_group_rule sg_rule_tcp22 {
#  group     = ibm_is_vpc.vpc.default_security_group
#  direction = "inbound"
#  remote    = "0.0.0.0/0"
#  tcp {
#    port_min = 22
#    port_max = 22
#  }
#}
#resource ibm_is_security_group_rule sg_rule_ping {
#  group     = ibm_is_vpc.vpc.default_security_group
#  direction = "inbound"
#  remote    = "0.0.0.0/0"
#  icmp {
#    type = 8
#    code = 0
#  }
#}

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

resource ibm_is_vpc_address_prefix vpc_address_zone1 {
  count = "${var.create_zone1_prefix == true ? 1 : 0}"
  name = "${var.vpc_name}-zone1-prefix"
  zone = "${var.region}-1"
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.zone1_cidr
  is_default = false
}

resource ibm_is_vpc_address_prefix vpc_address_zone2 {
  count = "${var.create_zone2_prefix == true ? 1 : 0}"
  name = "${var.vpc_name}-zone2-prefix"
  zone = "${var.region}-2"
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.zone2_cidr
  is_default = false
}

resource ibm_is_vpc_address_prefix vpc_address_zone3 {
  count = "${var.create_zone3_prefix == true ? 1 : 0}"
  name = "${var.vpc_name}-zone3-prefix"
  zone = "${var.region}-3"
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.zone3_cidr
  is_default = false
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



