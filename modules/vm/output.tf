output "ips" {
  value       = libvirt_domain.domain.network_interface.0.addresses.0
  description = "Primary IP Addresses of machine(s)"
}

output "cloudinit_iso" {
  value       = libvirt_cloudinit_disk.cloudinit.name
  description = "Name(s) of cloudinit disk(s) in the pool specified"
}

output "root_disk" {
  value       = libvirt_volume.volume.name
  description = "Root volume"
}

output "base_image" {
  value       = libvirt_volume.base.name
  description = "Base for Root volume aka Cloud Image base"
}
