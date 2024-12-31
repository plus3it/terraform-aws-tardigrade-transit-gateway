# terraform-aws-tardigrade-transit-gateway/cross-region-peering-attachment

Terraform module for managing a cross-region Transit Gateway Peering Attachment. The two providers
may be the same or different accounts, but must be different regions.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

No providers.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_peer_region"></a> [peer\_region](#input\_peer\_region) | Region of EC2 Transit Gateway to peer with | `string` | n/a | yes |
| <a name="input_peer_transit_gateway_id"></a> [peer\_transit\_gateway\_id](#input\_peer\_transit\_gateway\_id) | ID of the Transit Gateway to peer with | `string` | n/a | yes |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | ID of the Transit Gateway | `string` | n/a | yes |
| <a name="input_options"></a> [options](#input\_options) | Object of options for the TGW peering attachment | <pre>object({<br/>    dynamic_routing = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_peer_account_id"></a> [peer\_account\_id](#input\_peer\_account\_id) | ID of the AWS account that owns the Transit Gateway peer | `string` | `null` | no |
| <a name="input_peer_transit_gateway_route_table_association"></a> [peer\_transit\_gateway\_route\_table\_association](#input\_peer\_transit\_gateway\_route\_table\_association) | ID of the Peer Transit Gateway route table to associate with the Peering attachment (an attachment can be associated with a single TGW route table) | <pre>object({<br/>    transit_gateway_route_table_id = string<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to the TGW peering attachments | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_route_table_association"></a> [transit\_gateway\_route\_table\_association](#input\_transit\_gateway\_route\_table\_association) | ID of the Transit Gateway route table to associate with the Peering attachment (an attachment can be associated with a single TGW route table) | <pre>object({<br/>    transit_gateway_route_table_id = string<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peering_accepter"></a> [peering\_accepter](#output\_peering\_accepter) | Object with the Transit Gateway peering attachment accepter attributes |
| <a name="output_peering_attachment"></a> [peering\_attachment](#output\_peering\_attachment) | Object with the Transit Gateway peering attachment attributes |

<!-- END TFDOCS -->
