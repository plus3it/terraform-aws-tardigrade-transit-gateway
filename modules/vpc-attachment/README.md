# terraform-aws-tardigrade-transit-gateway/vpc-attachment

Terraform module for managing a Transit Gateway VPC Attachment. This module will manage the attachment,
as well as any Transit Gateway route table association or propagations, and VPC routes.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subnet\_ids | List of subnets to associate with the VPC attachment | `list(string)` | n/a | yes |
| transit\_gateway\_id | ID of the Transit Gateway | `string` | n/a | yes |
| cross\_account | Boolean whether this is a cross-account Transit Gateway shared via Resource Access Manager | `bool` | `false` | no |
| dns\_support | Whether DNS support is enabled. Valid values: disable, enable | `string` | `"enable"` | no |
| ipv6\_support | Whether IPv6 support is enabled. Valid values: disable, enable | `string` | `"disable"` | no |
| tags | Map of tags to apply to the TGW VPC attachment | `map(string)` | `{}` | no |
| transit\_gateway\_default\_route\_table\_association | Boolean whether the VPC Attachment should be associated to the Transit Gateway default route table | `bool` | `true` | no |
| transit\_gateway\_default\_route\_table\_propagation | Boolean whether the VPC Attachment should propagate routes to the Transit Gateway propagation default route table | `bool` | `true` | no |
| transit\_gateway\_route\_table\_association | ID of the Transit Gateway route table to associate with the VPC attachment (an attachment can be associated with a single TGW route table) | <pre>object({<br>    transit_gateway_route_table_id = string<br>  })</pre> | `null` | no |
| transit\_gateway\_route\_table\_propagations | List of Transit Gateway route tables this VPC attachment will propagate routes to | <pre>list(object({<br>    # `name` is used as for_each key<br>    name                           = string<br>    transit_gateway_route_table_id = string<br>  }))</pre> | `[]` | no |
| vpc\_routes | List of VPC route objects with a target of the VPC attachment | <pre>list(object({<br>    # `name` is used as for_each key<br>    name                        = string<br>    route_table_id              = string<br>    destination_cidr_block      = string<br>    destination_ipv6_cidr_block = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| route\_table\_association | Object with the Transit Gateway route table association attributes |
| route\_table\_propagations | Map of Transit Gateway route table propagation objects |
| vpc\_attachment | Object with the Transit Gateway VPC attachment attributes |
| vpc\_routes | Map of VPC route objects |

<!-- END TFDOCS -->
