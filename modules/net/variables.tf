
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
  description = "Network Mode. Can be `none`, `nat`, `bridge`. If bridge is specified, an existing `bridge_name` device MUST be specified."
}

variable "bridge_device" {
  type        = string
  default     = null
  description = "Name of the bridge device. ONLY used if mode is `bridge`. This should already be present. Module will not creaet this for you."
}
