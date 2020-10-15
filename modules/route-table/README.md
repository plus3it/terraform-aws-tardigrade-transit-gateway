# terraform-aws-tardigrade-transit-gateway/route-table

Terraform module for managing a Transit Gateway Route Table.

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
| transit\_gateway\_id | ID of EC2 Transit Gateway | `string` | n/a | yes |
| tags | Map of tags to apply to the TGW route table | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| route\_table | Object with the Transit Gateway route table attributes |

<!-- END TFDOCS -->
