<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_libvirt"></a> [libvirt](#requirement\_libvirt) | 0.6.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_libvirt"></a> [libvirt](#provider\_libvirt) | 0.6.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [libvirt_cloudinit_disk.cloudinit](https://registry.terraform.io/providers/dmacvicar/libvirt/0.6.10/docs/resources/cloudinit_disk) | resource |
| [libvirt_domain.domain](https://registry.terraform.io/providers/dmacvicar/libvirt/0.6.10/docs/resources/domain) | resource |
| [libvirt_volume.base](https://registry.terraform.io/providers/dmacvicar/libvirt/0.6.10/docs/resources/volume) | resource |
| [libvirt_volume.volume](https://registry.terraform.io/providers/dmacvicar/libvirt/0.6.10/docs/resources/volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudimage"></a> [cloudimage](#input\_cloudimage) | URL for cloud image. If using local path use pathexpand(path) | `string` | n/a | yes |
| <a name="input_cloudimage_format"></a> [cloudimage\_format](#input\_cloudimage\_format) | Format of the cloudimage disk | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of libvrt domain, Name of the VM | `string` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Userdata | `string` | n/a | yes |
| <a name="input_address"></a> [address](#input\_address) | IP address of VM (static) | `string` | `null` | no |
| <a name="input_arch"></a> [arch](#input\_arch) | VM architecture. Change only if your are emulating other CPUs. | `string` | `"x86_64"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size in GB | `number` | `20` | no |
| <a name="input_firmware"></a> [firmware](#input\_firmware) | Path to OVMF firmware on host. If set to nil, UEFI is disabled (Currently not supported) | `string` | `"/usr/share/OVMF/OVMF_CODE.ms.fd"` | no |
| <a name="input_libvirt_uri"></a> [libvirt\_uri](#input\_libvirt\_uri) | libvirt URI | `string` | `"qemu:///system"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory to allocate for VM | `number` | `512` | no |
| <a name="input_network"></a> [network](#input\_network) | Name of the Network to connect VM to | `string` | `"default"` | no |
| <a name="input_pool"></a> [pool](#input\_pool) | Storage pool to use | `string` | `"default"` | no |
| <a name="input_running"></a> [running](#input\_running) | Whether the VM created is running, Defaults to true | `bool` | `true` | no |
| <a name="input_vcpu"></a> [vcpu](#input\_vcpu) | VCPUs to assign | `number` | `1` | no |
| <a name="input_vcpu_model_host"></a> [vcpu\_model\_host](#input\_vcpu\_model\_host) | Use host CPU model for Guest | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_base_image"></a> [base\_image](#output\_base\_image) | Base for Root volume aka Cloud Image base |
| <a name="output_cloudinit_iso"></a> [cloudinit\_iso](#output\_cloudinit\_iso) | Name of cloudinit disk in the pool specified |
| <a name="output_id"></a> [id](#output\_id) | Domain ID |
| <a name="output_ips"></a> [ips](#output\_ips) | IP Addresses of machine |
| <a name="output_name"></a> [name](#output\_name) | Name of the VM/libvirt domain |
| <a name="output_root_disk"></a> [root\_disk](#output\_root\_disk) | Root volume |

<!-- END_TF_DOCS -->
