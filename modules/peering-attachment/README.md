# terraform-aws-tardigrade-transit-gateway/peering-attachment

Terraform module for managing a Transit Gateway Peering Attachment.

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
| peer\_region | Region of EC2 Transit Gateway to peer with | `string` | n/a | yes |
| peer\_transit\_gateway\_id | ID of the Transit Gateway to peer with | `string` | n/a | yes |
| transit\_gateway\_id | ID of the Transit Gateway | `string` | n/a | yes |
| peer\_account\_id | ID of the AWS account that owns the Transit Gateway peer | `string` | `null` | no |
| tags | Map of tags to apply to the TGW peering attachment | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| peering\_attachment | Object with the Transit Gateway peering attachment attributes |

<!-- END TFDOCS -->
