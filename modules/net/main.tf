resource "libvirt_network" "net" {
  # the name used by libvirt
  name = var.name

  # Allowed: "nat" (default), "none", "bridge"
  mode = var.mode

  # If bridge specify bridge device
  bridge = var.mode == "bridge" ? var.bridge_device : null

  # The domain used by the DNS server in this network
  domain = var.domain_name

  # DHCP Subnets
  addresses = var.dhcp_subnets

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
