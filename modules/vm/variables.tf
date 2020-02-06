variable "cloud_image_url" {
  type        = string
  description = "Cloud Image URL"
}

variable "disk_size" {
  type        = number
  description = "Root FS disk size in GB. Please do not specify it in bytes!"
  default     = 20

  // validation {
  //   condition     = var.disk_size < 10240
  //   error_message = "RootFS sixe MUST be in GB. It looks like you ar using it in other units."
  // }
}

variable "network" {
  type        = string
  description = "Network Name to attach VM"
  default     = "default"
}

variable "wait_for_lease" {
  type        = bool
  description = "Wait until the network interface gets a DHCP lease from libvirt"
  default     = true
}

variable "pool" {
  type        = string
  description = "Pool for Disks"
  default     = "default"
}

variable "domain_prefix" {
  type        = string
  description = "Domain Prefix. If count is > 1, -{count} is appended to the domain created. Seperator can be configured with variable."
}

variable "cpu_count" {
  type        = number
  description = "CPUs to allocate to VM"
  default     = 1

  // validation {
  //   condition     = var.cpu_count >= 1
  //   error_message = "Number of vCPUs to allocate MUST be positive integer."
  // }
}

variable "cpu_model_host" {
  type        = bool
  default     = true
  description = "Set CPU Model to Host"
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
  default     = null
}

variable "user_data_path" {
  description = "Path to User data config"
  type        = string
}

variable "vm_count" {
  description = "Number of VM Instances to create"
  default     = 1
  type        = number
}

variable "cloud_image_pool" {
  description = "Pool to use downloaded cloud images"
  default     = "default"
  type        = string
}

variable "domain_prefix_index_seperator" {
  description = "Charachter to be used for seperating domain prefix and index. Only applies if count is > 1"
  type        = string
  default     = "-"

  // validation {
  //   condition     = length(var.domain_prefix_index_seperator) < 2 && can(regex("^$|[-_]", var.domain_prefix_index_seperator))
  //   error_message = "The seperator can be either empty, hyphen or underscore."
  // }
}
