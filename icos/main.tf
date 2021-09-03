data "ibm_resource_group" "cos_group" {
  name = var.resource_group_name
}
resource "ibm_resource_instance" "cos_instance" {
  name              = var.cos_instance_name
  resource_group_id = data.ibm_resource_group.cos_group.id
  service           = "cloud-object-storage"
  plan              = "lite"
  location          = "global"
}

resource "ibm_cos_bucket" "backet" {
  bucket_name           = var.bucket_name
  resource_instance_id  = ibm_resource_instance.cos_instance.id
  cross_region_location	= var.cross_regional_loc
  bucket_type		= "cross_region_location"
  bucket_region		= var.bucket_region
  storage_class         = var.storage
  hard_quota            = var.quota
}

