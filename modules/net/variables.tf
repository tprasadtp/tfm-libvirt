
variable "name" {
  type        = string
  description = "Name of the Network"
}

variable "domain_name" {
  type        = string
  description = "Network Domain Name"
}

variable "dhcp_subnet" {
  type        = string
  description = "DHCP Subnet"
}

variable "autostart" {
  type        = bool
  default     = false
  description = "Auto Start Network after boot"
}
