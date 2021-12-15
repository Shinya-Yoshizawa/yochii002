variable "zone1" {
  default = "dev-kd-jp-osa-zone1"
}

variable "zone2" {
  default = "dev-kd-jp-osa-zone2"
}

variable "zone3" {
  default = "dev-kd-jp-osa-zone3"
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "image" {
  default = "r006-ed3f775f-ad7e-4e37-ae62-7199b4988b00"
}

variable "profile" {
  default = "cx2-2x4"
}

variable "image_cos_url" {
  default = "cos://us-south/cosbucket-vpc-image-gen2/rhel-guest-image-7.0-encrypted.qcow2"
}

variable "image_operating_system" {
  default = "red-7-amd64"
}

variable "cidr1" {
  default = "10.248.0.0/18"
}

variable "resource_group" {
  default = "dev-costomer-direct"
}
