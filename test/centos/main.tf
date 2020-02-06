module "vnet" {
  source      = "../../modules/net"
  name        = "centos"
  domain_name = "centos.kvm"
  dhcp_subnet = "192.168.129.0/24"
}

module "virtual_machine" {
  source = "../../modules/vm"

  # Name of the VM
  cloud_image_url = "https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2"
  domain_prefix   = "centos"
  network         = "centos"
  user_data_path  = "./user-data.cfg"
  vm_count        = 1
  wait_for_lease  = false
  cpu_model_host  = true

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
