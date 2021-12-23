# Parent Account IBM Cloud Provider
provider ibm {
    region                = var.region
    ibmcloud_timeout      = 60
}

# Resource Group where VPC will be created
data ibm_resource_group resource_group {
  name = var.resource_group
}

# Create a VPC
resource ibm_is_vpc vpc {
  name           = var.vpc_name
  resource_group = data.ibm_resource_group.resource_group.id
  classic_access = var.classic_access
}

# Default Security Group
resource ibm_is_security_group sg_def {
  name = var.default_security_group_name
  vpc  = ibm_is_vpc.vpc.id
}

# Default Security Group Rule
#resource ibm_is_security_group_rule sg_rule_tcp22 {
#  group     = ibm_is_security_group.sg_def.id
#  direction = "inbound"
#  remote    = "0.0.0.0/0"
#  tcp {
#    port_min = 22
#    port_max = 22
#  }
#}
#resource ibm_is_security_group_rule sg_rule_ping {
#  group     = ibm_is_security_group.sg_def.id
#  direction = "inbound"
#  remote    = "0.0.0.0/0"
#  icmp {
#    type = 8
#    code = 0
#  }
#}
#resource ibm_is_security_group_rule sg_rule_egress {
#  group     = ibm_is_security_group.sg_def.id
#  direction = "egress"
#  remote    = "0.0.0.0/0"
#}
