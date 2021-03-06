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

resource "ibm_cos_bucket" "bucket" {
  bucket_name           = var.bucket_name
  region_location	= var.region_location
  resource_instance_id  = ibm_resource_instance.cos_instance.id
  storage_class         = var.storage
  hard_quota            = var.quota
}

