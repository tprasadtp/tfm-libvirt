terraform {
  required_providers {
    libvirt = {
      source  = "local.tprasadtp.github.io/local/libvirt"
      version = "0.6.2"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.14"
}