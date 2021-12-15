resource "ibm_is_vpc" "vpc1" {
  name = var.vpc_name
  resource_group = var.resource_group
  default_network_acl = var.network_acl
  default_routing_table = var.routing_table
  default_security_group = var.security_group
}

resource "ibm_is_vpc_address_prefix" "sabnet_prefix" {
  name        = "dev-kd-jp-osa-subnet"
  zone        = var.zone1
  vpc         = ibm_is_vpc.vpc1.id
	cidr        = var.cidr1
	is_default  = true
}

resource "ibm_is_vpc_route" "route" {
  name        = "route1"
  vpc         = ibm_is_vpc.vpc1.id
  zone        = var.zone1
  destination = "192.168.0.0/24"
  next_hop    = "10.248.0.1"
  depends_on  = [ibm_is_subnet.subnet1]
}

resource "ibm_is_subnet" "subnet1" {
  name            = "subnet1"
  vpc             = ibm_is_vpc.vpc1.id
  zone            = var.zone1
  ipv4_cidr_block = "10.248.0.0/28"
}

