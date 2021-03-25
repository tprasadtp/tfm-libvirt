module "vnet" {
  source       = "../../modules/net"
  name         = "test"
  domain_name  = "test.kvm"
  dhcp_subnets = ["192.168.127.0/24"]
}


module "virtual_machine" {
  source             = "../../modules/vm"
  cloud_image_url    = pathexpand("~/Virtual/installers/cloudimages/ubuntu-focal/focal-server-cloudimg-amd64.img")
  cloud_image_format = "qcow2"
  domain_prefix      = "test"
  network_name       = "test"
  user_data          = file("${path.module}/user-data.cfg")
  vm_count           = 2
  vcpu               = 1
  vmem               = 512
  cpu_model_host     = true
  enable_uefi        = true
  # ansible does not like hyphens in its dicts.
  # this just sets seperator to "" to avoid it.
  domain_prefix_index_seperator = "_"
}

output "ips" {
  value = module.virtual_machine.ips
}

output "cloudinit_iso" {
  value = module.virtual_machine.cloudinit_iso
}

output "domain_volumes" {
  value = module.virtual_machine.domain_volumes
}

output "hostnames" {
  value = module.virtual_machine.hostnames
}
