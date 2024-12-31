# terraform-aws-tardigrade-transit-gateway/peering-accepter

Terraform module for managing a Transit Gateway Peering Attachment Accepter.

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
| <a name="input_peering_attachment_id"></a> [peering\_attachment\_id](#input\_peering\_attachment\_id) | ID of the TGW peering attachment | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to the TGW peering attachment | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_route_table_association"></a> [transit\_gateway\_route\_table\_association](#input\_transit\_gateway\_route\_table\_association) | ID of the Transit Gateway route table to associate with the Peering attachment (an attachment can be associated with a single TGW route table) | <pre>object({<br/>    transit_gateway_route_table_id = string<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peering_attachment_accepter"></a> [peering\_attachment\_accepter](#output\_peering\_attachment\_accepter) | Object with the Transit Gateway peering attachment accepter attributes |

<!-- END TFDOCS -->
