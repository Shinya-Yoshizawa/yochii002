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
