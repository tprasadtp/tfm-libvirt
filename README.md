# Terraform Modules for libvirt provider

This repository contains terraform modules to quickly create `libvirt` VMs from cloud images using [Terraform][terraform] with [libvirt][terraform-libvirt] provider.

[![TFM](https://github.com/tprasadtp/tfm-libvirt/workflows/terraform/badge.svg)](https://github.com/tprasadtp/tfm-libvirt/actions?workflow=terraform)
![Terraform-Version](https://img.shields.io/badge/terraform-1.0.x-623CE4?logo=terraform)
![libvirt-Version](https://img.shields.io/badge/provider--libvirt-0.6.10-623CE4?logo=terraform&logoColor=white)
![Analytics](https://ga-beacon.prasadt.com/UA-101760811-3/github/tfm-libvirt?pink&useReferer)

## Requirements

- KVM supported Linux Machine
- `libvirtd` is up and running
- [Terraform][terraform] and [terraform-libvirt][terraform-libvirt] plugins installed.

## Usage

- `modules/net` - [Creates a Network](./modules/net/README.md)
  ```hcl

  module "vnet" {
    source = "git::https://github.com/tprasadtp/tfm-libvirt.git//modules/net"
    name   = "test"
    domain = "test.kvm"
    subnet = "192.168.127.0/24"
  }
  ```

- `modules/vm` - [Creates VM](./modules/vm/README.md)

  ```hcl
  module "vm" {
    source            = "git::https://github.com/tprasadtp/tfm-libvirt.git//modules/vm"
    cloudimage        = pathexpand("~/Virtual/installers/focal-server-cloudimg-amd64.img")
    cloudimage_format = "raw"
    name              = "test"
    network           = "test"
    vcpu              = 1
    memory            = 256
    vcpu_model_host   = true
    user_data         = file("${path.module}/user-data.cfg")
  }
  ```

## Notes

- This module is meant to quickly create headless machines in a reproducible way.
- VMs with UI are **NOT** supported!, vm module even strips off all video/spice devices!
- Advanced configs are not supported. You might look into provider's documentation for creating VMs which support additional features.

## Tests

- Tests spin up VMs and asserts they are running with right config using ansible.
- You can use already installed version of ansible if you wish. Otherwise, `poetry install`

## Cloud images

VMs use cloud images as its easier to configure them them using `cloud-init`.

## Supported Guest OS

- [Ubuntu](https://cloud-images.ubuntu.com/)
- [CentOS](http://cloud.centos.org/centos/8/x86_64/images/)
- [Debian](http://cdimage.debian.org/cdimage/openstack/)
- [Fedora](https://alt.fedoraproject.org/cloud/)
- [OpenSUSE](https://software.opensuse.org/distributions/leap#jeos-ports)
- ArchLinux(You must build the qcow2 image or use openstack image if available)

[terraform]: https://terraform.io
[terraform-libvirt]: https://github.com/dmacvicar/terraform-provider-libvirt
