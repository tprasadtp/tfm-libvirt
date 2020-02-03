# Terraform Modules for libvirt provider

This repository contains terraform modules to quickly create `libvirt` VMs from cloud images using [Terraform][terraform]
with [libvirt][terraform-libvirt] provider.

[![TFM](https://github.com/tprasadtp/tfm-libvirt/workflows/terraform/badge.svg)](https://github.com/tprasadtp/tfm-libvirt/actions?workflow=terraform)
![Terraform-Version](https://img.shields.io/badge/terraform-0.12.x-623CE4?logo=terraform)
![libvirt-Version](https://img.shields.io/badge/provider--libvirt-0.6.1-623CE4?logo=terraform&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-brightgreen)
[![Labels](https://github.com/tprasadtp/tfm-libvirt/workflows/labels/badge.svg)](https://github.com/tprasadtp/tfm-libvirt/actions?workflow=labels)
![Analytics](https://ga-beacon.prasadt.com/UA-101760811-3/github/tfm-libvirt?pink&useReferer)


## Requirements

- KVM supported Linux Machine
- `libvirtd` is up and running
- Can access qemu:///system without priv escalation
- [Terraform][terraform] and [terraform-libvirt][terraform-libvirt] plugins installed.

## Usage

Just like use it any other terraform module.

```console
terrafom init
terraform plan
terraform apply
```

> It is recommended to add this repo as a submodule
> and use the terraform modules from modules folder.
> This module is meant to quickly create headless machines in a reproducible way. GPU and other advanced configs are not supported.
> You might look into provider's documentation for creating VMs which support additional features.

## Tests

Tests spin up VMs and asserts they are running with right config using ansible.

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
