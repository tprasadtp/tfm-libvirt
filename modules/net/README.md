# net

Libvirt Network - Create a libvirt network. This wont work if using libvirt user session.

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
| [libvirt_network.net](https://registry.terraform.io/providers/dmacvicar/libvirt/0.6.10/docs/resources/network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | Network DHCP Domain Name | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the Network | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | DHCP Subnet | `string` | n/a | yes |
| <a name="input_autostart"></a> [autostart](#input\_autostart) | Auto Start Network after boot | `bool` | `true` | no |
| <a name="input_libvirt_uri"></a> [libvirt\_uri](#input\_libvirt\_uri) | libvirt URI | `string` | `"qemu:///system"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Network ID |
| <a name="output_name"></a> [name](#output\_name) | n/a |

<!-- END_TF_DOCS -->
