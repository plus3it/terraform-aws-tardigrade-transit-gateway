# terraform-aws-tardigrade-transit-gateway/vpc-accepter

Terraform module for managing a Transit Gateway VPC Attachment Accepter. This module is used in a
cross-account VPC attachment workflow. This module will manage the attachment, as well as any Transit
Gateway route table association or propagations, and VPC routes.

<!-- BEGIN TFDOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| transit\_gateway\_attachment\_id | ID of the TGW attachment | `string` | n/a | yes |
| tags | Map of tags to apply to the TGW attachment | `map(string)` | `{}` | no |
| transit\_gateway\_default\_route\_table\_association | Boolean whether the VPC Attachment should be associated to the Transit Gateway default route table | `bool` | `true` | no |
| transit\_gateway\_default\_route\_table\_propagation | Boolean whether the VPC Attachment should propagate routes to the Transit Gateway propagation default route table | `bool` | `true` | no |
| transit\_gateway\_route\_table\_association | ID of the Transit Gateway route table to associate with the VPC attachment (an attachment can be associated with a single TGW route table) | <pre>object({<br>    transit_gateway_route_table_id = string<br>  })</pre> | `null` | no |
| transit\_gateway\_route\_table\_propagations | List of Transit Gateway route tables this VPC attachment will propagate routes to | <pre>list(object({<br>    # `name` is used as for_each key<br>    name                           = string<br>    transit_gateway_route_table_id = string<br>  }))</pre> | `[]` | no |
| vpc\_routes | List of VPC route objects with a target of the VPC attachment | <pre>list(object({<br>    route_table_id              = string<br>    destination_cidr_block      = string<br>    destination_ipv6_cidr_block = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| route\_table\_association | Object with the Transit Gateway route table association attributes |
| route\_table\_propagations | Map of Transit Gateway route table propagation objects |
| vpc\_attachment\_accepter | Object with the Transit Gateway VPC attachment accepter attributes |
| vpc\_routes | Map of VPC route objects |

<!-- END TFDOCS -->
