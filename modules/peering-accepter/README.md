# terraform-aws-tardigrade-transit-gateway/peering-accepter

Terraform module for managing a Transit Gateway Peering Attachment Accepter.

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
| peering\_attachment\_id | ID of the TGW peering attachment | `string` | n/a | yes |
| tags | Map of tags to apply to the TGW peering attachment | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| peering\_attachment\_accepter | Object with the Transit Gateway peering attachment accepter attributes |

<!-- END TFDOCS -->
