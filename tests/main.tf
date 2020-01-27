module "vnet" {
  source              = "../modules/net"
  network_name        = "test"
  network_domain_name = "test.kvm"
  network_dhcp_subnet = "192.168.127.0/24"
}


module "virtual_machine" {
  source = "../modules/vm"

  # Name of the VM
  domain_prefix  = "test"
  user_data_path = "./user-data.cfg"
  vm_count       = 2
}

provider "libvirt" {
  uri = "qemu:///system"
}
