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
}

# Default Security Group Rule
resource ibm_is_security_group_rule sg_rule_tcp22 {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}
resource ibm_is_security_group_rule sg_rule_ping {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    type = 8
    code = 0
  }
}

resource ibm_is_vpc_address_prefix vpc_address_zone1 {
  name = "${var.vpc_name}-zone1-prefix"
  zone = var.region
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.zone1_cidr
}

resource ibm_is_vpc_address_prefix vpc_address_zone2 {
  name = "${var.vpc_name}-zone2-prefix"
  zone = var.region
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.zone2_cidr
}

resource ibm_is_vpc_address_prefix vpc_address_zone3 {
  name = "${var.vpc_name}-zone3-prefix"
  zone = var.region
  vpc  = ibm_is_vpc.vpc.id
  cidr = var.zone3_cidr
}


