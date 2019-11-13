# terraform-aws-tardigrade-transit-gateway-attachment

Terraform module to create a transit gateway attachment in one account and accept the attachment in the owner account

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_tgw\_attachment | Controls whether to create the TGW attachment | string | `"true"` | no |
| dns\_support | (Optional) Whether DNS support is enabled. Valid values: disable, enable. | string | `"enable"` | no |
| name | The name of the TGW attachment for tagging purposes | string | `"null"` | no |
| subnet\_ids | A list of subnets inside the VPC | list | `<list>` | no |
| tags | A map of tags to apply to the TGW attachment | map | `<map>` | no |
| transit\_gateway\_id | The ID of the Transit Gateway | string | `"null"` | no |
| vpc\_id | VPC ID to attach to the TGW | string | `"null"` | no |

## Outputs

| Name | Description |
|------|-------------|
| transit\_gateway\_attachment\_id | The ID of the Transit Gateway Attachment |

