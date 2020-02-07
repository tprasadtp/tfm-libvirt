output "ips" {
  value       = libvirt_domain.domain.*.network_interface.0.addresses.0
  description = "Primary IP Addresses of machine(s)"
}

output "cloudinit_volumes" {
  value       = libvirt_cloudinit_disk.cloudinit.*.name
  description = "Name(s) of cloudinit disk(s) in the pool specified"
}

output "domain_volumes" {
  value       = libvirt_volume.volume.*.name
  description = "Name(s) of COW volume(s) for VM(s), in the pool specified"
}

output "hostnames" {
  value       = data.null_data_source.resource_names.*.outputs.hostnames
  description = "Hostname(s) as seen by cloudinit"
}
