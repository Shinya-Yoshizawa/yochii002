resource "ibm_is_vpc" "vpc1" {
  name = var.vpc_name
  resource_group = var.resource_group
}

resource "ibm_is_vpc_address_prefix" "zone1_sabnet_prefix" {
  name        = var.zone1_subnet_prefix_name
  zone        = var.zone1
  vpc         = ibm_is_vpc.vpc1.id
	cidr        = var.cidr1
	is_default  = true
}

resource "ibm_is_vpc_address_prefix" "zone2_sabnet_prefix" {
  name        = var.zone2_subnet_prefix_name
  zone        = var.zone2
  vpc         = ibm_is_vpc.vpc1.id
	cidr        = var.cidr1
}

resource "ibm_is_vpc_address_prefix" "zone3_sabnet_prefix" {
  name        = var.zone3_subnet_prefix_name
  zone        = var.zone3
  vpc         = ibm_is_vpc.vpc1.id
	cidr        = var.cidr1
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
  name            = var.subnet_name
  vpc             = ibm_is_vpc.vpc1.id
  zone            = [var.zone1,var.zone2,var.zone3]
  ipv4_cidr_block = "10.248.0.0/28"
}

