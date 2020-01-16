terraform {
  required_version = "~> 0.12.0"
}

provider aws {
  region = "us-east-1"
}

provider aws {
  region  = "us-east-1"
  alias   = "owner"
  profile = "owner"
}

data "aws_caller_identity" "current" {}

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
  number  = false
}

resource "aws_ram_resource_share" "this" {
  provider = aws.owner

  name                      = "tardigrade-tgw-${local.test_id}"
  allow_external_principals = true

  tags = {
    Environment = "testing"
  }
}

resource "aws_ec2_transit_gateway" "this" {
  provider = aws.owner

  description = "tardigrade-tgw-${local.test_id}"
}

resource "aws_ram_resource_association" "this" {
  provider = aws.owner

  resource_arn       = aws_ec2_transit_gateway.this.arn
  resource_share_arn = aws_ram_resource_share.this.arn
}

resource "aws_ram_principal_association" "this" {
  provider = aws.owner

  principal          = data.aws_caller_identity.current.account_id
  resource_share_arn = aws_ram_resource_share.this.arn
}

locals {
  test_id = random_string.this.result
}

output "tgw_id" {
  value = aws_ec2_transit_gateway.this.id
}

output "test_id" {
  value = local.test_id
}
