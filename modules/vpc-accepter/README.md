# terraform-aws-tardigrade-transit-gateway/vpc-accepter

Terraform module for managing a Transit Gateway VPC Attachment Accepter. This module is used in a
cross-account VPC attachment workflow. This module will manage the attachment, as well as any Transit
Gateway route table association or propagations, and VPC routes.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_transit_gateway_attachment_id"></a> [transit\_gateway\_attachment\_id](#input\_transit\_gateway\_attachment\_id) | ID of the TGW attachment | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to the TGW attachment | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_default_route_table_association"></a> [transit\_gateway\_default\_route\_table\_association](#input\_transit\_gateway\_default\_route\_table\_association) | Boolean whether the VPC Attachment should be associated to the Transit Gateway default route table | `bool` | `true` | no |
| <a name="input_transit_gateway_default_route_table_propagation"></a> [transit\_gateway\_default\_route\_table\_propagation](#input\_transit\_gateway\_default\_route\_table\_propagation) | Boolean whether the VPC Attachment should propagate routes to the Transit Gateway propagation default route table | `bool` | `true` | no |
| <a name="input_transit_gateway_route_table_association"></a> [transit\_gateway\_route\_table\_association](#input\_transit\_gateway\_route\_table\_association) | ID of the Transit Gateway route table to associate with the VPC attachment (an attachment can be associated with a single TGW route table) | <pre>object({<br>    transit_gateway_route_table_id = string<br>  })</pre> | `null` | no |
| <a name="input_transit_gateway_route_table_propagations"></a> [transit\_gateway\_route\_table\_propagations](#input\_transit\_gateway\_route\_table\_propagations) | List of Transit Gateway route tables this VPC attachment will propagate routes to | <pre>list(object({<br>    # `name` is used as for_each key<br>    name                           = string<br>    transit_gateway_route_table_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_routes"></a> [vpc\_routes](#input\_vpc\_routes) | List of VPC route objects with a target of the VPC attachment | <pre>list(object({<br>    # `name` is used as for_each key<br>    name                        = string<br>    route_table_id              = string<br>    destination_cidr_block      = string<br>    destination_ipv6_cidr_block = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table_association"></a> [route\_table\_association](#output\_route\_table\_association) | Object with the Transit Gateway route table association attributes |
| <a name="output_route_table_propagations"></a> [route\_table\_propagations](#output\_route\_table\_propagations) | Map of Transit Gateway route table propagation objects |
| <a name="output_vpc_attachment_accepter"></a> [vpc\_attachment\_accepter](#output\_vpc\_attachment\_accepter) | Object with the Transit Gateway VPC attachment accepter attributes |
| <a name="output_vpc_routes"></a> [vpc\_routes](#output\_vpc\_routes) | Map of VPC route objects |

<!-- END TFDOCS -->
