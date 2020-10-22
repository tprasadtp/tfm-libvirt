## Providers

| Name | Version |
|------|---------|
| libvirt | 0.6.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bridge\_device | Name of the bridge device. ONLY used if mode is `bridge`. This should already be present. Module will not creaet this for you. | `string` | n/a | yes |
| dhcp\_subnets | DHCP Subnets | `list(string)` | n/a | yes |
| domain\_name | Network Domain Name | `string` | n/a | yes |
| name | Name of the Network | `string` | n/a | yes |
| autostart | Auto Start Network after boot | `bool` | `false` | no |
| libvirt\_uri | libvirt URI | `string` | `"qemu:///system"` | no |
| mode | Network Mode. Can be `none` or `nat` or `bridge`. If net to bridge, `bridge_device` name MUST be specified! | `string` | `"nat"` | no |

## Outputs

No output.

