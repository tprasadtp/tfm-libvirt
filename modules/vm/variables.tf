variable "cloudimage_url" {
  type        = string
  description = "Cloud Image URL"
  default     = "https://cloud-images.ubuntu.com/minimal/releases/bionic/release/ubuntu-18.04-minimal-cloudimg-amd64.img"
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
  type        = string
}

variable "user_data_path" {
  description = "Path to User data config"
  type        = string
}

variable "cloudimage_pool" {
  description = "Cloud Image Pool. This is where downloaded cloud images will be stored"
  default     = null
}
