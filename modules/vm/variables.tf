variable "cloud_image_url" {
  type        = string
  description = "Cloud Image URL"
}

variable "cloud_image_format" {
  type        = string
  description = "Cloud Image Format"

  // validation {
  //   condition     = var.cloud_image_format != "raw" || var.cloud_image_format != "qcow2"
  //   error_message = "Image format can be qcow2 or raw."
  // }
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

variable "network_name" {
  type        = string
  description = "Network Name to attach VM"
  default     = "default"
}

variable "vm_addresses" {
  type        = list(string)
  description = "List of addresses to assing to VMs. These MUST be in the network. If you wish to create multiple VMs, but only few with specified IP, import this module twice and specifu vm-address in one of them."
  default     = null

  // check if length is same as count
  // validation {
  //   condition     = var.vm_addresses == null || length(var.vm_addresses) == var.vm_count
  //   error_message = "Invalid length when not null. List should be as long as number of VMs to create."
  // }
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
  description = "Domain Prefix. Domains will be named {prefix}{seperator}{index}. Same pattern will be used for hostnames and volume names."
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

variable "architecture" {
  type        = string
  description = "Valid CPU architecture. If you set this to to non native architecture, You **MUST** set `cpu_model_host` to `false`"
  default     = "x86_64"

  // validation {
  //   condition     = var.architecture == "x86_64" || var.architecture == "aarch64"
  //   error_message = "We only Support 64 bit images(for now)."
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

variable "enable_uefi" {
  type        = bool
  description = "Enable UEFI. You MUST have a supported system, suppoeted guest image and have `ovmf`(Debian.Ubuntu) or `edk2-ovmf`(RHEL/CentOS) package installed."
  default     = false
}

variable "uefi_firmware_path" {
  description = "Path to OVFM firmware. Only applies if `enable_uefi` is set to true. Default is only valid on Debian hosts. On CentOS hosts, use `/usr/share/OVMF/OVMF_CODE.secboot.fd`"
  type        = string
  default     = "/usr/share/OVMF/OVMF_CODE.fd"
}
