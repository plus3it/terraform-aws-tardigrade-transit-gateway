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

module "create_attachment" {
  source = "../../"

  providers = {
    aws       = aws
    aws.owner = aws.owner
  }

  create_tgw_attachment = true
  name                  = "tardigrade-tgw-${local.test_id}"
  routes                = local.routes
  subnet_ids            = module.vpc.private_subnets
  transit_gateway_id    = aws_ec2_transit_gateway.this.id
  vpc_id                = module.vpc.vpc_id

  dependencies = [
    aws_ram_resource_association.this.id,
  ]
}

module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"

  providers = {
    aws = aws
  }

  name            = "tardigrade-tgw-${local.test_id}"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
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
  count    = local.create_ram_principal_association ? 1 : 0
  provider = aws.owner

  principal          = data.aws_caller_identity.this.account_id
  resource_share_arn = aws_ram_resource_share.this.arn
}

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
  number  = false
}

data "aws_caller_identity" "this" {}

data "aws_caller_identity" "owner" {
  provider = aws.owner
}

locals {
  test_id                          = random_string.this.result
  create_ram_principal_association = data.aws_caller_identity.this.account_id != data.aws_caller_identity.owner.account_id
  remote_ipv4_cidr                 = "10.1.0.0/16"

  routes = [for rt in concat(module.vpc.public_route_table_ids, module.vpc.private_route_table_ids) :
    {
      route_table_id              = rt
      destination_cidr_block      = local.remote_ipv4_cidr
      destination_ipv6_cidr_block = null
    }
  ]
}
