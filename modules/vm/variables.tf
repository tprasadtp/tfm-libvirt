
variable "cloudimage" {
  type        = string
  description = "URL for cloud image. If using local path use pathexpand(path)"
}

variable "cloudimage_format" {
  type        = string
  description = "Format of the cloudimage disk"
  validation {
    condition     = var.cloudimage_format == "raw" || var.cloudimage_format == "qcow2"
    error_message = "Cloud image format can be raw or qcow2."
  }
}

variable "name" {
  type        = string
  description = "Name of libvrt domain, Name of the VM"
}

variable "memory" {
  type        = number
  description = "Memory to allocate for VM"
  default     = 512
  validation {
    condition     = var.memory >= 128
    error_message = "Virtual machine must have a memory greater or equals 128 MiB."
  }
}

variable "vcpu" {
  type        = number
  description = "VCPUs to assign"
  default     = 1
  validation {
    condition     = var.vcpu >= 1
    error_message = "Virtial machine must have 1 or more CPUs."
  }
}

variable "vcpu_model_host" {
  type        = bool
  description = "Use host CPU model for Guest"
  default     = true
}

variable "arch" {
  type        = string
  default     = "x86_64"
  description = "VM architecture. Change only if your are emulating other CPUs."
}

variable "running" {
  type        = bool
  default     = true
  description = "Whether the VM created is running, Defaults to true"
}

variable "address" {
  type        = string
  default     = null
  description = "IP address of VM (static)"
}

variable "network" {
  type        = string
  default     = "default"
  description = "Name of the Network to connect VM to"
}

variable "pool" {
  type        = string
  default     = "default"
  description = "Storage pool to use"
}

variable "disk_size" {
  type        = number
  default     = 20
  description = "Disk size in GB"
}

variable "user_data" {
  type        = string
  description = "Userdata"
}

variable "firmware" {
  type        = string
  default     = "/usr/share/OVMF/OVMF_CODE.fd"
  description = "Path to OVMF firmware on host. If set to nil, UEFI is disabled"
}
