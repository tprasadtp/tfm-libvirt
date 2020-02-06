# Base Image
resource "libvirt_volume" "base" {
  pool = var.cloud_image_pool

  // Get the URL and use the image name as volume name
  name = format("%s-%s", var.domain_prefix, element(split("/", var.cloud_image_url), length(split("/", var.cloud_image_url)) - 1))

  #"https://cloud-images.ubuntu.com/minimal/releases/bionic/release/ubuntu-18.04-minimal-cloudimg-amd64.img"
  source = var.cloud_image_url
}

# Main root Volume
resource "libvirt_volume" "volume" {
  name           = var.vm_count > 1 ? format("%s%s%d.qcow2", var.domain_prefix, var.domain_prefix_index_seperator, count.index + 1) : var.domain_prefix
  base_volume_id = libvirt_volume.base.id
  pool           = var.pool
  size           = var.disk_size * 1024 * 1024 * 1024
  format         = "qcow2"
  count          = var.vm_count
}


# Cloud init config
data "template_file" "user_data" {
  count    = var.vm_count
  template = file(var.user_data_path)
  vars = {
    hostname = var.vm_count > 1 ? format("%s%s%d", var.domain_prefix, var.domain_prefix_index_seperator, count.index + 1) : var.domain_prefix
  }
}

# for more info about paramater check this out
# https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown
resource "libvirt_cloudinit_disk" "cloudinit" {
  count = var.vm_count
  name  = var.vm_count > 1 ? format("%s%s%d.iso", var.domain_prefix, var.domain_prefix_index_seperator, count.index + 1) : var.domain_prefix
  // user_data      = templatefile(var.user_data_path, { instance_name = format("%s-%d", var.domain_prefix, count.index+1)})
  user_data = element(data.template_file.user_data.*.rendered, count.index)
  pool      = var.pool
}

# Create the machine
resource "libvirt_domain" "domain" {

  count  = var.vm_count
  name   = var.vm_count > 1 ? format("%s%s%d", var.domain_prefix, var.domain_prefix_index_seperator, count.index + 1) : var.domain_prefix
  memory = var.memory_size
  vcpu   = var.cpu_count

  cpu = {
    mode = var.cpu_model_host == true ? "host-model" : null
  }

  cloudinit = element(libvirt_cloudinit_disk.cloudinit.*.id, count.index)

  network_interface {
    network_name   = var.network
    wait_for_lease = var.wait_for_lease

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
    volume_id = element(libvirt_volume.volume.*.id, count.index)
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
