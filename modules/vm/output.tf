output "ips" {
  value       = flatten(libvirt_domain.domain.network_interface[*].addresses[*])
  description = "IP Addresses of machine"
}

output "cloudinit_iso" {
  value       = libvirt_cloudinit_disk.cloudinit.name
  description = "Name of cloudinit disk in the pool specified"
}

output "root_disk" {
  value       = libvirt_volume.volume.name
  description = "Root volume"
}

output "base_image" {
  value       = libvirt_volume.base.name
  description = "Base for Root volume aka Cloud Image base"
}

output "id" {
  value = libvirt_domain.domain.id
  description = "Domain ID"
}

output "name" {
  value = libvirt_domain.domain.name
  description = "Name of the VM/libvirt domain"
}
