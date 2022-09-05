provider "aws" {
  region  = "us-east-1"
  profile = "aws"

  default_tags {
    tags = {
      TARDIGRADE_TEST = true
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  alias   = "owner"
  profile = "awsalternate"

  default_tags {
    tags = {
      TARDIGRADE_TEST = true
    }
  }
}

module "vpc_attachment" {
  source = "../../modules/cross-account-vpc-attachment"

  providers = {
    aws       = aws
    aws.owner = aws.owner
  }

  subnet_ids         = module.vpc_member.private_subnets
  transit_gateway_id = module.tgw.transit_gateway.id
  routes             = local.routes
  vpc_routes         = concat(local.vpc_routes_member, local.vpc_routes_owner)

  transit_gateway_route_table_association = {
    transit_gateway_route_table_id = module.tgw.route_tables["foo-${local.id}"].route_table.id
  }

  transit_gateway_route_table_propagations = [
    {
      # `name` is used as for_each key
      name                           = "foo-${local.id}"
      transit_gateway_route_table_id = module.tgw.route_tables["foo-${local.id}"].route_table.id
    },
    {
      name                           = "bar-${local.id}"
      transit_gateway_route_table_id = module.tgw.route_tables["bar-${local.id}"].route_table.id
    },
  ]

  depends_on = [
    module.tgw,
  ]
}

module "tgw" {
  source = "../.."
  providers = {
    aws = aws.owner
  }

  description  = "tardigrade-tgw-${local.id}"
  route_tables = local.route_tables

  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  vpc_attachments = [
    {
      # name used as for_each key
      name                   = "foo-${local.id}"
      subnet_ids             = module.vpc_owner.private_subnets
      appliance_mode_support = "disable"
      dns_support            = "enable"
      ipv6_support           = "disable"
      tags                   = {}
      vpc_routes             = []

      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = true
      transit_gateway_route_table_association         = null
      transit_gateway_route_table_propagations        = []
    },
  ]

  tags = {
    Name = "tardigrade-testing-${local.id}"
  }
}

locals {
  id = data.terraform_remote_state.prereq.outputs.test_id.result

  vpc_routes_member = [for i, rt in concat(module.vpc_member.public_route_table_ids, module.vpc_member.private_route_table_ids) :
    {
      name                        = "route-${i}"
      provider                    = "aws"
      route_table_id              = rt
      destination_cidr_block      = "10.0.0.0/16"
      destination_ipv6_cidr_block = null
    }
  ]

  vpc_routes_owner = [for i, rt in concat(module.vpc_owner.public_route_table_ids, module.vpc_owner.private_route_table_ids) :
    {
      name                        = "route-${i}"
      provider                    = "aws.owner"
      route_table_id              = rt
      destination_cidr_block      = "10.1.0.0/16"
      destination_ipv6_cidr_block = null
    }
  ]

  routes = [for i, rt in [
    {
      destination_cidr_block         = "10.2.0.0/24"
      transit_gateway_route_table_id = module.tgw.route_tables["foo-${local.id}"].route_table.id
    },
    {
      destination_cidr_block         = "10.3.0.0/24"
      transit_gateway_route_table_id = module.tgw.route_tables["bar-${local.id}"].route_table.id
    },
  ] : merge(rt, { name = "route-${i}-${local.id}" })]

  route_tables = [
    {
      name                    = "foo-${local.id}"
      tags                    = {}
      attachment_associations = []
      attachment_propagations = []
      routes                  = []
    },
    {
      name                    = "bar-${local.id}"
      tags                    = {}
      attachment_associations = []
      attachment_propagations = []
      routes = [
        {
          name                          = "route-bar1-${local.id}"
          blackhole                     = true
          destination_cidr_block        = "10.4.0.0/24"
          transit_gateway_attachment_id = null
        },
      ]
    },
  ]
}

module "ram_share" {
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-ram-share.git?ref=4.0.0"
  providers = {
    aws = aws.owner
  }

  name                      = "tardigrade-tgw-${local.id}"
  allow_external_principals = true

  resources = [
    {
      name         = "tardigrade-tgw"
      resource_arn = module.tgw.transit_gateway.arn
    },
  ]
}

module "ram_share_accepter" {
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-ram-share.git//modules/cross_account_principal_association?ref=4.0.0"

  providers = {
    aws       = aws
    aws.owner = aws.owner
  }

  resource_share_arn = module.ram_share.resource_share.arn
}

module "vpc_member" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v3.14.2"

  name            = "tardigrade-tgw-${local.id}"
  cidr            = "10.1.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
}

module "vpc_owner" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v3.14.4"
  providers = {
    aws = aws.owner
  }

  name            = "tardigrade-tgw-${local.id}"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

output "vpc_attachment" {
  value = module.vpc_attachment
}
