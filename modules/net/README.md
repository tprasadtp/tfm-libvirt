## Providers

| Name | Version |
|------|---------|
| libvirt | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bridge\_device | Name of the bridge device. ONLY used if mode is `bridge`. This should already be present. Module will not creaet this for you. | `string` | n/a | yes |
| dhcp\_subnets | DHCP Subnets | `list(string)` | n/a | yes |
| domain\_name | Network Domain Name | `string` | n/a | yes |
| name | Name of the Network | `string` | n/a | yes |
| autostart | Auto Start Network after boot | `bool` | `false` | no |
| mode | Network Mode. Can be `none`, `nat`, `bridge`. If bridge is specified, an existing `bridge_name` device MUST be specified. | `string` | `"nat"` | no |

## Outputs

No output.

