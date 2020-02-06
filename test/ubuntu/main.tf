module "vnet" {
  source      = "../../modules/net"
  name        = "test"
  domain_name = "test.kvm"
  dhcp_subnet = "192.168.127.0/24"
}


module "virtual_machine" {
  source = "../../modules/vm"

  # Name of the VM
  cloud_image_url = "https://cloud-images.ubuntu.com/minimal/releases/bionic/release/ubuntu-18.04-minimal-cloudimg-amd64.img"
  domain_prefix   = "test"
  network         = "test"
  user_data_path  = "./user-data.cfg"
  vm_count        = 2
  cpu_model_host  = false
  # ansible does not like hyphens in its dicts.
  # this just sets seperator to "" to avoid it.
  domain_prefix_index_seperator = ""
}

provider "libvirt" {
  uri = "qemu:///system"
}

output "ip" {
  value = module.virtual_machine.ip
}
