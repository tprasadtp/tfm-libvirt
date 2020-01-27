# Terraform Modules for libvirt provider

This repository contains terraform modules tp quickly create `libvirt` VMs from cloud images using [Terraform][terraform]
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

## Cloud images

VMs use cloud images as its easier to configure them them using `cloud-init`.

## Supported OS

Following Guests are supported. Please specify an appropriate
image while running terraform. Links to cloud images are also mentioned below.

- [Ubuntu](https://cloud-images.ubuntu.com/)
- [CentOS](http://cloud.centos.org/centos/8/x86_64/images/)
- [Debian](http://cdimage.debian.org/cdimage/openstack/)
- [Fedora](https://alt.fedoraproject.org/cloud/)
- [OpenSUSE](https://software.opensuse.org/distributions/leap#jeos-ports)

[terraform]: https://terraform.io
[terraform-libvirt]: https://github.com/dmacvicar/terraform-provider-libvirt
