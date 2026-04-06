<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix_list_id"></a> [prefix\_list\_id](#input\_prefix\_list\_id) | ID of the prefix list to reference | `string` | n/a | yes |
| <a name="input_transit_gateway_route_table_id"></a> [transit\_gateway\_route\_table\_id](#input\_transit\_gateway\_route\_table\_id) | ID of the route table to associate with the prefix list | `string` | n/a | yes |
| <a name="input_blackhole"></a> [blackhole](#input\_blackhole) | Boolean indicating whether to drop traffic that matches this prefix list | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where the Transit Gateway is located (if different from the provider region) | `string` | `null` | no |
| <a name="input_transit_gateway_attachment_id"></a> [transit\_gateway\_attachment\_id](#input\_transit\_gateway\_attachment\_id) | ID of the attachment to associate with the prefix list | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route"></a> [route](#output\_route) | Object with the Transit Gateway prefix list reference attributes |

<!-- END TFDOCS -->
