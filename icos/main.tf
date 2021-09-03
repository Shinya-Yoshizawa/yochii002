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
#  single_site_location  = var.single_site_loc
  region_location	= var.regional_loc
  storage_class         = var.storage
  hard_quota            = var.quota
  static_web_service	= "1"
}

