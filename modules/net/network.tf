resource "libvirt_network" "net" {
  name = var.name

  # Allowed: "nat" (default), "none", "bridge"
  mode = "nat"

  # The domain used by the DNS server in this network
  domain = var.domain

  # DHCP Subnets
  addresses = [var.subnet]

  # Auto start
  autostart = var.autostart

  # (Optional) DNS configuration
  dns {
    # (Optional, default false)
    # Set to true, if no other option is specified and you still want to
    # enable dns.
    enabled = true
    # (Optional, default false)
    # true: DNS requests under this domain will only be resolved by the
    # virtual network's own DNS server
    # false: Unresolved requests will be forwarded to the host's
    # upstream DNS server if the virtual network's DNS server does not
    # have an answer.
    local_only = true
  }
}
