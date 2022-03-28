# terraform-aws-tardigrade-transit-gateway/cross-account-vpc-attachment

Terraform module for managing a cross-account Transit Gateway VPC Attachment.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.owner"></a> [aws.owner](#provider\_aws.owner) | >= 3.15.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnets to associate with the VPC attachment | `list(string)` | n/a | yes |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | ID of the Transit Gateway | `string` | n/a | yes |
| <a name="input_appliance_mode_support"></a> [appliance\_mode\_support](#input\_appliance\_mode\_support) | Whether Appliance Mode support is enabled. Valid values: disable, enable | `string` | `"disable"` | no |
| <a name="input_dns_support"></a> [dns\_support](#input\_dns\_support) | Whether DNS support is enabled. Valid values: disable, enable. | `string` | `"enable"` | no |
| <a name="input_ipv6_support"></a> [ipv6\_support](#input\_ipv6\_support) | Whether IPv6 support is enabled. Valid values: disable, enable | `string` | `"disable"` | no |
| <a name="input_routes"></a> [routes](#input\_routes) | List of TGW route objects with a target of the VPC attachment in the `aws.owner` account (TGW route tables are *only* in the `aws.owner` account) | <pre>list(object({<br>    # `name` is used as for_each key<br>    name                           = string<br>    destination_cidr_block         = string<br>    transit_gateway_route_table_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to the TGW attachments | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_default_route_table_association"></a> [transit\_gateway\_default\_route\_table\_association](#input\_transit\_gateway\_default\_route\_table\_association) | Boolean whether the VPC Attachment should be associated to the Transit Gateway default route table | `bool` | `true` | no |
| <a name="input_transit_gateway_default_route_table_propagation"></a> [transit\_gateway\_default\_route\_table\_propagation](#input\_transit\_gateway\_default\_route\_table\_propagation) | Boolean whether the VPC Attachment should propagate routes to the Transit Gateway propagation default route table | `bool` | `true` | no |
| <a name="input_transit_gateway_route_table_association"></a> [transit\_gateway\_route\_table\_association](#input\_transit\_gateway\_route\_table\_association) | ID of the Transit Gateway route table to associate with the VPC attachment (an attachment can be associated with a single TGW route table) | <pre>object({<br>    transit_gateway_route_table_id = string<br>  })</pre> | `null` | no |
| <a name="input_transit_gateway_route_table_propagations"></a> [transit\_gateway\_route\_table\_propagations](#input\_transit\_gateway\_route\_table\_propagations) | List of Transit Gateway route tables this VPC attachment will propagate routes to | <pre>list(object({<br>    # `name` is used as for_each key<br>    name                           = string<br>    transit_gateway_route_table_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_routes"></a> [vpc\_routes](#input\_vpc\_routes) | List of VPC route objects with a target of the transit gateway. | <pre>list(object({<br>    # `name` is used as for_each key<br>    name                        = string<br>    provider                    = string<br>    route_table_id              = string<br>    destination_cidr_block      = string<br>    destination_ipv6_cidr_block = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table_association"></a> [route\_table\_association](#output\_route\_table\_association) | Object with the Transit Gateway route table association attributes |
| <a name="output_route_table_propagations"></a> [route\_table\_propagations](#output\_route\_table\_propagations) | Map of Transit Gateway route table propagation objects |
| <a name="output_routes"></a> [routes](#output\_routes) | Map of Transit Gateway route objects |
| <a name="output_vpc_accepter"></a> [vpc\_accepter](#output\_vpc\_accepter) | Object with the Transit Gateway VPC attachment accepter attributes |
| <a name="output_vpc_attachment"></a> [vpc\_attachment](#output\_vpc\_attachment) | Object with the Transit Gateway VPC attachment attributes |
| <a name="output_vpc_routes"></a> [vpc\_routes](#output\_vpc\_routes) | Map of VPC route objects |

<!-- END TFDOCS -->
