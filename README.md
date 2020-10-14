# terraform-aws-tardigrade-transit-gateway

This module will manage a Transit Gateway, as well as its Route Tables, Routes, VPC attachments, Route
Table associations and propagations, and VPC routes associated with the VPC attachments.

## Submodules

This module includes several submodules for different workflows and use cases.

- [`cross-account-vpc-attachment`](modules/cross-account-vpc-attachment): Creates a cross-account Transit
  Gateway VPC Attachment by managing the invite/accept interaction between two accounts. Requires two
  providers, one for each account. The providers must be different accounts, and must be using the same
  region. The Transit Gateway must be shared using the AWS Resource Access Manager.
- [`cross-region-peering-attachment`](modules/cross-region-peering-attachment):: Creates a cross-region
  Peering Attachment, managing the invite/accept workflow between the two regions. Requires two providers,
  one for each region. The providers may be the same or different account, but **must** be different
  regions.
- [`peering-accepter`](modules/peering-accepter): Accepts a peering attachment request. Used by the
  cross-region-peering-attachment module.
- [`peering-attachment`](modules/peering-attachment): Sends a peering attachment invite. Used by the
  cross-region-peering-attachment module.
- [`route`](modules/route): Creates a Transit Gateway Route.
- [`route-table`](modules/route-table): Creates a Transit Gateway Route Table.
- [`vpc-accepter`](modules/vpc-accepter): Accepts a VPC attachment request. Used by the cross-account-vpc-attachment
  module. Will also the create Transit Gateway Route Table association and propagations for the attachment,
  and will manage VPC routes associated with the attachment.
- [`vpc-attachment`](modules/vpc-attachment): Sends a VPC attachment invite. Used by the cross-account-vpc-attachment
  module. Will also the create Transit Gateway Route Table association and propagations for the attachment,
  and will manage VPC routes associated with the attachment.

<!-- BEGIN TFDOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| amazon\_side\_asn | Private Autonomous System Number (ASN) for the Amazon side of a BGP session (range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASN) | `number` | `64512` | no |
| auto\_accept\_shared\_attachments | Whether resource attachment requests are automatically accepted (valid values: disable, enable) | `string` | `"disable"` | no |
| default\_route\_table\_association | Whether resource attachments are automatically associated with the default association route table (valid values: disable, enable) | `string` | `"enable"` | no |
| default\_route\_table\_propagation | Whether resource attachments automatically propagate routes to the default propagation route table (valid values: disable, enable) | `string` | `"enable"` | no |
| description | Description of the EC2 Transit Gateway | `string` | `null` | no |
| dns\_support | Whether DNS support is enabled (valid values: disable, enable) | `string` | `"enable"` | no |
| route\_tables | List of TGW route tables to create with the transit gateway | <pre>list(object({<br>    # `name` used as for_each key<br>    name = string<br>    tags = map(string)<br>  }))</pre> | `[]` | no |
| routes | List of TGW routes to add to TGW route tables | <pre>list(object({<br>    # `name` used as for_each key<br>    name                   = string<br>    blackhole              = bool<br>    default_route_table    = bool<br>    destination_cidr_block = string<br>    # name from `vpc_attachments` or id of a pre-existing tgw attachment<br>    transit_gateway_attachment = string<br>    # name from `route_tables` or id of a pre-existing route table<br>    transit_gateway_route_table = string<br>  }))</pre> | `[]` | no |
| tags | Whether VPN Equal Cost Multipath Protocol support is enabled (valid values: disable, enable) | `map(string)` | `{}` | no |
| vpc\_attachments | List of VPC attachments to create with the transit gateway | <pre>list(object({<br>    # `name` used as for_each key<br>    name         = string<br>    subnet_ids   = list(string)<br>    dns_support  = string<br>    ipv6_support = string<br>    tags         = map(string)<br>    vpc_routes = list(object({<br>      # `name` is used as for_each key<br>      name                        = string<br>      route_table_id              = string<br>      destination_cidr_block      = string<br>      destination_ipv6_cidr_block = string<br>    }))<br>    transit_gateway_default_route_table_association = bool<br>    transit_gateway_default_route_table_propagation = bool<br>    # name from `route_tables` or id of a pre-existing route table<br>    transit_gateway_route_table_association = string<br>    # list of route table names from `route_tables` or ids of pre-existing route tables<br>    transit_gateway_route_table_propagations = list(string)<br>  }))</pre> | `[]` | no |
| vpn\_ecmp\_support | Map of tags to apply to the TGW and associated resources | `string` | `"disable"` | no |

## Outputs

| Name | Description |
|------|-------------|
| route\_tables | Map of TGW route table objects |
| routes | Map of TGW route objects |
| transit\_gateway | Object with attributes of the Transit Gateway |
| vpc\_attachments | Map of TGW peering attachment objects |

<!-- END TFDOCS -->

## Testing

This module has tests that require multiple providers. In order to simplify the provider config, it
assumes you have AWS Profiles named `resource-owner` and `resource-member`. These profiles should
resolve a credential for two different accounts.
