# Base Image
resource "libvirt_volume" "base" {
  pool   = var.pool
  name   = format("%s-cloudimage.%s", var.name, var.cloudimage_format)
  source = var.cloudimage
  format = var.cloudimage_format
}

# Main root Volume
resource "libvirt_volume" "volume" {
  name           = format("%s.qcow2", var.name)
  base_volume_id = libvirt_volume.base.id
  pool           = var.pool
  size           = var.disk_size * 1024 * 1024 * 1024
  format         = "qcow2"
}


// For more info about paramater check this out
// https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown
resource "libvirt_cloudinit_disk" "cloudinit" {
  name      = format("%s.cloudinit.iso", var.name)
  user_data = var.user_data
  meta_data = format("local-hostname: %s\n ", var.name)
  pool      = var.pool
}

// Create the machine
resource "libvirt_domain" "domain" {
  name   = var.name
  memory = var.memory
  arch   = var.arch
  vcpu   = var.vcpu

  cpu = {
    mode = var.vcpu_model_host == true ? "host-model" : null
  }

  //Custom cmdline is not supported!
  cmdline = []

  // cloudinit
  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  network_interface {

    // Network must already exist
    network_name = var.network
    // Hostname is same as domain name
    // DHCP should handle FQDN
    hostname = var.name

    // Only provide IP when we have been provided one
    // This is a list as VMs can have multiple IPs(provider supports it).
    addresses      = var.address != null ? [var.address] : null
    wait_for_lease = true
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  // Remove graphics and video which are added by default :(
  xml {
    xslt = file("${path.module}/remove-graphics.xsl")
  }

  disk {
    scsi      = false
    volume_id = libvirt_volume.volume.id
  }

}
