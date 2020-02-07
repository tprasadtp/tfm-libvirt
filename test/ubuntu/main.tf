module "vnet" {
  source      = "../../modules/net"
  name        = "test"
  domain_name = "test.kvm"
  dhcp_subnet = "192.168.127.0/24"
}


module "virtual_machine" {
  source = "../../modules/vm"

  cloud_image_url = "https://cloud-images.ubuntu.com/minimal/releases/bionic/release/ubuntu-18.04-minimal-cloudimg-amd64.img"
  // cloud_image_url    = pathexpand("~/Public/ISO/ubuntu-18.04-minimal-cloudimg-amd64.img")
  cloud_image_format = "raw"
  domain_prefix      = "test"
  network            = "test"
  user_data_path     = "./user-data.cfg"
  vm_count           = 2
  cpu_model_host     = false
  # ansible does not like hyphens in its dicts.
  # this just sets seperator to "" to avoid it.
  domain_prefix_index_seperator = ""
}

provider "libvirt" {
  uri = "qemu:///system"
}

output "ips" {
  value = module.virtual_machine.ips
}

output "cloudinit_volumes" {
  value = module.virtual_machine.cloudinit_volumes
}

output "domain_volumes" {
  value = module.virtual_machine.domain_volumes
}

output "hostnames" {
  value = module.virtual_machine.hostnames
}
