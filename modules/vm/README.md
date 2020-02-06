## Providers

| Name | Version |
|------|---------|
| libvirt | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cloud\_image\_url | Cloud Image URL | `string` | n/a | yes |
| domain\_prefix | Domain Prefix. If count is > 1, -{count} is appended to the domain created. Seperator can be configured with variable. | `string` | n/a | yes |
| network\_config\_path | Path to Network config | `string` | n/a | yes |
| user\_data\_path | Path to User data config | `string` | n/a | yes |
| autostart | Autostart the Domain | `bool` | `false` | no |
| cloud\_image\_pool | Pool to use downloaded cloud images | `string` | `"default"` | no |
| cpu\_count | CPUs to allocate to VM | `number` | `1` | no |
| cpu\_model\_host | Set CPU Model to Host | `bool` | `true` | no |
| disk\_size | Root FS disk size in GB. Please do not specify it in bytes! | `number` | `20` | no |
| domain\_prefix\_index\_seperator | Charachter to be used for seperating domain prefix and index. Only applies if count is > 1 | `string` | `"-"` | no |
| memory\_size | Memory size in MiB | `number` | `512` | no |
| network | Network Name to attach VM | `string` | `"default"` | no |
| pool | Pool for Disks | `string` | `"default"` | no |
| vm\_count | Number of VM Instances to create | `number` | `1` | no |
| wait\_for\_lease | Wait until the network interface gets a DHCP lease from libvirt | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| ip | Primary IP Addresses of machine(s) |

