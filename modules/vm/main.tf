# A pool for all cluster volumes
resource "libvirt_pool" "iso" {
  name = "iso"
  type = "dir"
  path = pathexpand("~/Public/ISO-Images/Terraform")
  // If cloudimage_pool is null, we need this otherwise we dont
  count = var.cloudimage_pool == null ? 1 : 0

  // prevent destroying this
  lifecycle {
    prevent_destroy = true
  }
}

# Base Image
resource "libvirt_volume" "base" {
  // Because we used count on libvirt_pool.iso, terraform forces you to refer it by index
  pool = var.cloudimage_pool == null ? libvirt_pool.iso[0].id : var.cloudimage_pool

  // Get the URL and use the image name as volume name
  name = element(split("/", var.cloudimage_url), length(split("/", var.cloudimage_url)) - 1)

  #"https://cloud-images.ubuntu.com/minimal/releases/bionic/release/ubuntu-18.04-minimal-cloudimg-amd64.img"
  source = var.cloudimage_url
}

# Main root Volume
resource "libvirt_volume" "vm" {
  name           = var.domain
  base_volume_id = libvirt_volume.base.id
  pool           = var.pool
  size           = var.disk_size
  format         = "qcow2"
}


# Cloud init config
data "template_file" "user_data" {
  template = file(var.user_data_path)
}

data "template_file" "network_config" {
  template = file(var.network_config_path)
}

# for more info about paramater check this out
# https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown
resource "libvirt_cloudinit_disk" "cloudinit" {
  name           = format("%s-cloudinit.iso", var.domain)
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = var.pool
}

# Create the machine
resource "libvirt_domain" "domain" {
  name   = var.domain
  memory = var.memory_size
  vcpu   = var.cpu_count

  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  network_interface {
    network_name = var.network
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
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

  disk {
    volume_id = libvirt_volume.vm.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
