## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| libvirt | 0.6.2 |

## Providers

| Name | Version |
|------|---------|
| libvirt | 0.6.2 |

## Modules

No Modules.

## Resources

| Name |
|------|

| libvirt_cloudinit_disk

| libvirt_domain

| libvirt_volume

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_image\_format | Cloud Image Format | `string` | n/a | yes |
| cloud\_image\_url | Cloud Image URL | `string` | n/a | yes |
| domain\_prefix | Domain Prefix. Domains will be named {prefix}{seperator}{index}. Same pattern will be used for hostnames and volume names. | `string` | n/a | yes |
| architecture | Valid CPU architecture. If you set this to to non native architecture, You **MUST** set `cpu_model_host` to `false` | `string` | `"x86_64"` | no |
| autostart | Autostart the Domain | `bool` | `false` | no |
| cloud\_image\_pool | Pool to use downloaded cloud images | `string` | `"default"` | no |
| cpu\_model\_host | Set CPU Model to Host | `bool` | `true` | no |
| disk\_size | Root FS disk size in GB. Please do not specify it in bytes! | `number` | `20` | no |
| domain\_prefix\_index\_seperator | Charachter to be used for seperating domain prefix and index. Only applies if count is > 1 | `string` | `"-"` | no |
| enable\_uefi | Enable UEFI. You MUST have a supported system, suppoeted guest image and have `ovmf`(Debian.Ubuntu) or `edk2-ovmf`(RHEL/CentOS) package installed. | `bool` | `false` | no |
| network\_config\_path | Path to Network config | `string` | `null` | no |
| network\_name | Network Name to attach VM | `string` | `"default"` | no |
| pool | Pool for Disks | `string` | `"default"` | no |
| uefi\_firmware\_path | Path to OVFM firmware. Only applies if `enable_uefi` is set to true. Default is only valid on Debian hosts. On CentOS hosts, use `/usr/share/OVMF/OVMF_CODE.secboot.fd` | `string` | `"/usr/share/OVMF/OVMF_CODE.fd"` | no |
| user\_data | Path to User data | `string` | `""` | no |
| vcpu | CPUs to allocate to VM | `number` | `1` | no |
| vm\_addresses | List of addresses to assign to VMs. These MUST be in the network. If you wish to create multiple VMs, but only few with specified IP, import this module twice and specifu vm-address in one of them. | `list(string)` | `null` | no |
| vm\_count | Number of VM Instances to create | `number` | `1` | no |
| vmem | Memory to allocate to VM in MiB | `number` | `512` | no |
| wait\_for\_lease | Wait until the network interface gets a DHCP lease from libvirt | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudinit\_iso | Name(s) of cloudinit disk(s) in the pool specified |
| domain\_volumes | Name(s) of COW volume(s) for VM(s), in the pool specified |
| hostnames | Hostname(s) as seen by cloudinit |
| ips | Primary IP Addresses of machine(s) |
