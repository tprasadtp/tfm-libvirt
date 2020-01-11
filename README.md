# Terraform KVM VMs

This repository is to quickly create `libvirt` VMs from cloud images using [Terraform][terraform]
with [libvirt][tlibvirt] provider.

## Requirements

- KVM supported Linux Machine
- `libvirtd` is up and running
- Can access qemu:\\system without priv escalation
- [Terraform][terraform] and [terraform-libvirt][tlibvirt] plugins installed.

## Usage

Just like any terraform code

```console
terrafom init
terraform plan
terraform apply
```

> tfstate is saved locally.

## Cloud images

VMs use cloud image as opposed to server images, as its easier to provision with them.

## Supported OS

- Ubuntu
- CentOS
- Debian

Sample Cloud init configs are in cloud-init folder
