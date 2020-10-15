provider aws {
  region  = "us-east-1"
  profile = "resource-member"
}

provider aws {
  region  = "us-east-1"
  alias   = "owner"
  profile = "resource-owner"
}

module vpc_attachment {
  source = "../../modules/cross-account-vpc-attachment"

  providers = {
    aws       = aws
    aws.owner = aws.owner
  }

  ram_share_id                = module.ram_share_accepter.share_accepter.share_id
  ram_resource_association_id = module.ram_share.resource_associations["tardigrade-tgw"].resource_association.id

  subnet_ids         = module.vpc.private_subnets
  transit_gateway_id = module.tgw.transit_gateway.id
  routes             = local.routes
  vpc_routes         = local.vpc_routes

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
}

module tgw {
  source = "../.."
  providers = {
    aws = aws.owner
  }

  description  = "tardigrade-tgw-${local.id}"
  route_tables = local.route_tables

  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = "tardigrade-testing-${local.id}"
  }
}

locals {
  id = data.terraform_remote_state.prereq.outputs.test_id.result

  vpc_routes = [for i, rt in concat(module.vpc.public_route_table_ids, module.vpc.private_route_table_ids) :
    {
      name                        = "route-${i}"
      provider                    = "aws"
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

module ram_share {
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-ram-share.git?ref=3.0.0"
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

module ram_share_accepter {
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-ram-share.git//modules/cross_account_principal_association?ref=3.0.0"

  providers = {
    aws       = aws
    aws.owner = aws.owner
  }

  resource_share_arn = module.ram_share.resource_share.arn
}

module vpc {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.57.0"

  name            = "tardigrade-tgw-${local.id}"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

data terraform_remote_state prereq {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

output vpc_attachment {
  value = module.vpc_attachment
}
