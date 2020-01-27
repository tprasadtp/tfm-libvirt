## Providers

| Name | Version |
|------|---------|
| libvirt | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cloudimage\_pool | Cloud Image Pool. This is where downloaded cloud images will be stored | `any` | n/a | yes |
| domain | Ubuntu domain Name | `string` | n/a | yes |
| network\_config\_path | Path to Network config | `string` | n/a | yes |
| user\_data\_path | Path to User data config | `string` | n/a | yes |
| autostart | Autostart the Domain | `bool` | `false` | no |
| cloudimage\_url | Cloud Image URL | `string` | `"https://cloud-images.ubuntu.com/minimal/releases/bionic/release/ubuntu-18.04-minimal-cloudimg-amd64.img"` | no |
| cpu\_count | CPUs to allocate to VM | `number` | `1` | no |
| disk\_size | Root FS disk size | `number` | `20` | no |
| memory\_size | Memory size in MiB | `number` | `512` | no |
| network | Network Name to attach VM | `string` | `"default"` | no |
| pool | Pool for Disks | `string` | `"default"` | no |

## Outputs

No output.

