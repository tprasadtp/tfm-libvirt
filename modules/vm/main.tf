# Base Image
resource "libvirt_volume" "base" {
  pool = var.cloud_image_pool

  // Get the URL and use the image name as volume name
  name   = format("%s-%s", var.domain_prefix, element(split("/", var.cloud_image_url), length(split("/", var.cloud_image_url)) - 1))
  source = var.cloud_image_url
  format = var.cloud_image_format
}


locals {
  hostnames = [for i in range(var.vm_count) : format("%s%s%d", var.domain_prefix, var.domain_prefix_index_seperator, i + 1)]
}

# Main root Volume
resource "libvirt_volume" "volume" {
  count = var.vm_count

  name           = format("%s.qcow2", local.hostnames[count.index])
  base_volume_id = libvirt_volume.base.id
  pool           = var.pool
  size           = var.disk_size * 1024 * 1024 * 1024
  format         = "qcow2"
}



// For more info about paramater check this out
// https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown
resource "libvirt_cloudinit_disk" "cloudinit" {
  count     = var.vm_count
  name      = format("%s.cloudinit.iso", local.hostnames[count.index])
  user_data = var.user_data
  meta_data = format("local-hostname: %s\n ", local.hostnames[count.index])
  pool      = var.pool
}

// Create the machine
resource "libvirt_domain" "domain" {
  count = var.vm_count

  name   = local.hostnames[count.index]
  memory = var.vmem
  arch   = var.architecture
  vcpu   = var.vcpu

  cpu = {
    mode = var.cpu_model_host == true ? "host-model" : null
  }

  # This file is usually present as part of the ovmf firmware package in many
  # Linux distributions.
  firmware = var.enable_uefi == true ? var.uefi_firmware_path : null

  // cloudinit
  cloudinit = libvirt_cloudinit_disk.cloudinit[count.index].id

  network_interface {

    // Network must already exist
    network_name = var.network_name
    hostname     = format("%s.qcow2", local.hostnames[count.index])

    // only provide IP when we have been provided one
    // This is a list as VMs can have multiple IPs(provider supports it).
    // But this module only support one IP per machine from libvirt network.
    addresses      = var.vm_addresses != null ? [var.vm_addresses[count.index]] : null
    wait_for_lease = var.wait_for_lease
  }

  // IMPORTANT: this is a known bug on cloud images, as they expect a console
  // we need to pass it
  // https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  disk {
    volume_id = libvirt_volume.volume[count.index].id
  }

}
