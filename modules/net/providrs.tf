terraform {
  required_providers {
    libvirt = {
      source  = "local.tprasadtp.github.io/local/libvirt"
      version = "0.6.2"
    }
  }
  required_version = ">= 0.14"
}
