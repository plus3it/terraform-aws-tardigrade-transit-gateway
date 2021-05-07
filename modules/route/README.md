# terraform-aws-tardigrade-transit-gateway/route

Terraform module for managing a Transit Gateway Route.

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
| <a name="input_destination_cidr_block"></a> [destination\_cidr\_block](#input\_destination\_cidr\_block) | IPv4 CIDR range used for destination matches | `string` | n/a | yes |
| <a name="input_transit_gateway_route_table_id"></a> [transit\_gateway\_route\_table\_id](#input\_transit\_gateway\_route\_table\_id) | ID of EC2 Transit Gateway Route Table | `string` | n/a | yes |
| <a name="input_blackhole"></a> [blackhole](#input\_blackhole) | Boolean indicating whether to drop traffic that matches this route | `bool` | `false` | no |
| <a name="input_transit_gateway_attachment_id"></a> [transit\_gateway\_attachment\_id](#input\_transit\_gateway\_attachment\_id) | ID of EC2 Transit Gateway Attachment (required if `blackhole` is `false`) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route"></a> [route](#output\_route) | Object with the Transit Gateway route attributes |

<!-- END TFDOCS -->
