output "ip" {
  value       = libvirt_domain.domain.*.network_interface.0.addresses
  description = "Primary IP Addresses of machine(s)"
}
