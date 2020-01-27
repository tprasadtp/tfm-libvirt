resource "libvirt_network" "net" {
  # the name used by libvirt
  name = var.network_name

  # Allowed: "nat" (default), "none", "route", "bridge"
  mode = "nat"

  # The domain used by the DNS server in this network
  domain = var.network_domain_name

  # DHHCP Sebnets
  addresses = [var.network_dhcp_subnet]

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
