variable "libvirt_uri" {
  type        = string
  description = "libvirt URI"
  default     = "qemu:///system"
}

variable "name" {
  type        = string
  description = "Name of the Network"
}

variable "domain" {
  type        = string
  description = "Network DHCP Domain Name"
}

variable "subnet" {
  type        = string
  description = "DHCP Subnet"
}

variable "autostart" {
  type        = bool
  default     = true
  description = "Auto Start Network after boot"
}
