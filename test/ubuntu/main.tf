module "vnet" {
  source = "../../modules/net"
  name   = "test"
  domain = "test.kvm"
  subnet = "192.168.127.0/24"
}


module "vm" {
  source            = "../../modules/vm"
  cloudimage        = pathexpand("~/Virtual/installers/ubuntu-21.04-minimal-cloudimg-amd64.img")
  cloudimage_format = "qcow2"
  name              = "test"
  network           = "test"
  vcpu              = 1
  memory            = 256
  vcpu_model_host   = true
  user_data         = file("${path.module}/user-data.cfg")
}

output "ips" {
  value = module.vm.ips
}
