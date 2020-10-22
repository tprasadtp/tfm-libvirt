variable "libvirt_uri" {
  type        = string
  description = "libvirt URI"
  default     = "qemu:///system"
}

variable "name" {
  type        = string
  description = "Name of the Network"
}

variable "domain_name" {
  type        = string
  description = "Network Domain Name"
}

variable "dhcp_subnets" {
  type        = list(string)
  description = "DHCP Subnets"
}

variable "autostart" {
  type        = bool
  default     = false
  description = "Auto Start Network after boot"
}

variable "mode" {
  type        = string
  default     = "nat"
  description = "Network Mode. Can be `none` or `nat` or `bridge`. If net to bridge, `bridge_device` name MUST be specified!"
  validation {
    condition     = var.mode == "none" || var.mode == "nat"
    error_message = "Network mode can be none or nat or bridge."
  }
}

variable "bridge_device" {
  type        = string
  default     = null
  description = "Name of the bridge device. ONLY used if mode is `bridge`. This should already be present. Module will not creaet this for you."
}
