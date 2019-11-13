# terraform-aws-tardigrade-transit-gateway-attachment

This module assumes there are 2 accounts involved in the process. The first account is the `owner` of the transit gateway and
has shared it with the second account. This module will attach a VPC that exists in the second account to the shared transit
gateway and then go into the first account and accept the attachment.

## Tests
Given the necessity of two accounts to test this module, the tests assume one of the AWS profiles used for credentials is
called owner.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_tgw\_attachment | Controls whether to create the TGW attachment | bool | `"true"` | no |
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

