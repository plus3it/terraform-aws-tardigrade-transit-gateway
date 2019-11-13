# terraform-aws-tardigrade-transit-gateway-attachment

This module assumes there are 2 accounts involved in the process. The first account is the `owner` of the transit gateway and
has shared it with the second account. This module will attach a VPC that exists in the second account to the shared transit
gateway and then go into the first account and accept the attachment.

## Tests
Given the necessity of two accounts to test this module, the tests assume one of the AWS profiles used for credentials is
called owner.
