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
  name           = var.vpcname
  resource_group = data.ibm_resource_group.resource_group.id
  classic_access = var.classic_access
}

# Update default security group
locals {
  # Convert to object
  security_group_rules = [
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
  security_group_rule_object = {
#    for rule in var.security_group_rules:
    for rule in security_group_rules:
    rule.name => rule
  }
}

resource ibm_is_security_group_rule default_vpc_rule {
  for_each  = local.security_group_rule_object
  group     = ibm_is_vpc.vpc.default_security_group
  direction = each.value.direction
  remote    = each.value.remote

  dynamic tcp { 
    for_each = each.value.tcp == null ? [] : [each.value]
    content {
      port_min = each.value.tcp.port_min
      port_max = each.value.tcp.port_max
    }
  }

  dynamic udp { 
    for_each = each.value.udp == null ? [] : [each.value]
    content {
      port_min = each.value.udp.port_min
      port_max = each.value.udp.port_max
    }
  } 

  dynamic icmp { 
    for_each = each.value.icmp == null ? [] : [each.value]
    content {
      type = each.value.icmp.type
      code = each.value.icmp.code
    }
  } 
}

# Public Gateways (Optional)
locals {
  use_public_gateways = {
    zone-1 = true
    zone-2 = true
    zone-3 = true
  }
  # create object that only contains gateways that will be created
  gateway_object = {
  #  for zone in keys(var.use_public_gateways):
    for zone in keys(use_public_gateways):
      zone => "${var.region}-${index(keys(var.use_public_gateways), zone) + 1}" if var.use_public_gateways[zone]
  }
}

resource ibm_is_public_gateway gateway {
  for_each       = local.gateway_object
  name           = "${var.prefix}-public-gateway-${each.key}"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.resource_group.id
  zone           = each.value
}

# ZONE
resource ibm_is_subnet subnet_1 {
  vpc               = var.vpc_id
  name              = "zone-1"
  zone              = "dev-kd-jp-osa-zone1"
  resource_group_id = data.ibm_resource_group.resource_group.id
#  ipv4_cidr_block   = subnet_prefix_1.cidr
  ipv4_cidr_block   = "10.10.10.0/24"
#  network_acl       = ibm_is_network_acl.multizone_acl.id
  routing_table     = null
}

resource ibm_is_subnet subnet_2 {
  vpc               = var.vpc_id
  name              = "zone-2"
  zone              = "dev-kd-jp-osa-zone2"
  resource_group_id = data.ibm_resource_group.resource_group.id
#  ipv4_cidr_block   = subnet_prefix_2.cidr
  ipv4_cidr_block   = "10.10.20.0/24"
#  network_acl       = ibm_is_network_acl.multizone_acl.id
  routing_table     = null
}

resource ibm_is_subnet subnet_3 {
  vpc               = var.vpc_id
  name              = "zone-3"
  zone              = "dev-kd-jp-osa-zone3"
  resource_group_id = data.ibm_resource_group.resource_group.id
#  ipv4_cidr_block   = subnet_prefix_3.cidr
  ipv4_cidr_block   = "10.10.30.0/24"
#  network_acl       = ibm_is_network_acl.multizone_acl.id
  routing_table     = null
}

