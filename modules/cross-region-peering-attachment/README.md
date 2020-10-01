# terraform-aws-tardigrade-transit-gateway/cross-region-peering-attachment

Terraform module for managing a cross-region Transit Gateway Peering Attachment. The two providers
may be the same or different accounts, but must be different regions.

<!-- BEGIN TFDOCS -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| peer\_region | Region of EC2 Transit Gateway to peer with | `string` | n/a | yes |
| peer\_transit\_gateway\_id | ID of the Transit Gateway to peer with | `string` | n/a | yes |
| transit\_gateway\_id | ID of the Transit Gateway | `string` | n/a | yes |
| peer\_account\_id | ID of the AWS account that owns the Transit Gateway peer | `string` | `null` | no |
| tags | Map of tags to apply to the TGW peering attachments | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| peering\_accepter | Object with the Transit Gateway peering attachment accepter attributes |
| peering\_attachment | Object with the Transit Gateway peering attachment attributes |

<!-- END TFDOCS -->
