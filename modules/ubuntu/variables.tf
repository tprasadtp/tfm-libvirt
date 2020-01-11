variable "cloudimage_url" {
  type        = string
  description = "Cloud Image URL"
  default     = "bionic"
}

variable "disk_size" {
  type        = number
  description = "Root FS disk size"
  default     = 20
}

variable "network" {
  type        = string
  description = "Network Name to attach VM"
  default     = "default"
}

variable "pool" {
  type        = string
  description = "Pool for Disks"
  default     = "default"
}

variable "domain" {
  type        = string
  description = "Ubuntu domain Name"
}

variable "cpu_count" {
  type        = number
  description = "CPUs to allocate to VM"
  default     = 1
}

variable "memory_size" {
  type        = number
  description = "Memory size in MiB"
  default     = 512
}

variable "autostart" {
  type        = bool
  description = "Autostart the Domain"
  default     = false
}

variable "network_config_path" {
  description = "Path to Network config"
  default     = null
}

variable "user_data_path" {
  description = "Path to User data config"
  default     = null
}
