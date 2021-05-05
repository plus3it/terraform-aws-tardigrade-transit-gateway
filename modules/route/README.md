# terraform-aws-tardigrade-transit-gateway/route

Terraform module for managing a Transit Gateway Route.

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
| destination\_cidr\_block | IPv4 CIDR range used for destination matches | `string` | n/a | yes |
| transit\_gateway\_route\_table\_id | ID of EC2 Transit Gateway Route Table | `string` | n/a | yes |
| blackhole | Boolean indicating whether to drop traffic that matches this route | `bool` | `false` | no |
| transit\_gateway\_attachment\_id | ID of EC2 Transit Gateway Attachment (required if `blackhole` is `false`) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| route | Object with the Transit Gateway route attributes |

<!-- END TFDOCS -->
