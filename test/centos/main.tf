module "virtual_machine" {
  source = "../../modules/vm"

  # Name of the VM
  # cloud_image_url = "https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2"
  cloud_image_url    = pathexpand("~/Virtual/installers/cloudimages/centos-8/CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2")
  cloud_image_format = "qcow2"
  domain_prefix      = "centos"
  network_name       = "default"
  user_data_path     = "./user-data.cfg"
  vm_count           = 1
  vcpu               = 1
  vmem             = 512
  cpu_model_host     = true

  # ansible does not like hyphens in its dicts.
  # this just sets seperator to "" to avoid it.
  domain_prefix_index_seperator = ""
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
