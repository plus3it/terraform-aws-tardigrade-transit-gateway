provider "aws" {
  region  = "us-east-1"
  profile = "aws"
}

module "tgw" {
  source = "../.."

  amazon_side_asn                 = 64512
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  description                     = "Testing for tardigrade ${local.id}"
  dns_support                     = "enable"
  vpn_ecmp_support                = "disable"

  route_tables    = local.route_tables
  routes          = local.routes
  vpc_attachments = local.vpc_attachments

  tags = {
    Name = "tardigrade-testing-${local.id}"
  }
}

locals {
  id = data.terraform_remote_state.prereq.outputs.test_id.result

  route_tables = [
    {
      # name used as for_each key
      name = "foo-${local.id}"
      tags = {}
    },
    {
      name = "bar-${local.id}"
      tags = {}
    },
  ]

  routes = [
    {
      # `name` used as for_each key
      name                   = "route-foo-foo-10.2.0.0/24"
      blackhole              = false
      default_route_table    = false
      destination_cidr_block = "10.2.0.0/24"
      # name from `vpc_attachments` or id of a pre-existing tgw attachment
      transit_gateway_attachment = "foo-${local.id}"
      # name from `route_tables` or id of a pre-existing route table
      transit_gateway_route_table = "foo-${local.id}"
    },
    {
      name                        = "route-foo-bar-10.3.0.0/24"
      blackhole                   = false
      default_route_table         = false
      destination_cidr_block      = "10.3.0.0/24"
      transit_gateway_attachment  = "foo-${local.id}"
      transit_gateway_route_table = "bar-${local.id}"
    },
    {
      name                   = "route-foo-blackhole-10.4.0.0/24"
      blackhole              = true
      default_route_table    = false
      destination_cidr_block = "10.4.0.0/24"
      # null is valid when blackhole is true
      transit_gateway_attachment  = null
      transit_gateway_route_table = "foo-${local.id}"
    },
    {
      name                        = "route-default-foo-10.2.0.0/24"
      blackhole                   = false
      default_route_table         = true
      destination_cidr_block      = "10.2.0.0/24"
      transit_gateway_attachment  = "foo-${local.id}"
      transit_gateway_route_table = null
    },
    {
      name                        = "route-default-blackhole-10.4.0.0/24"
      blackhole                   = true
      default_route_table         = true
      destination_cidr_block      = "10.4.0.0/24"
      transit_gateway_attachment  = null
      transit_gateway_route_table = null
    },
  ]

  vpc_attachments = [
    {
      # name used as for_each key
      name                   = "foo-${local.id}"
      subnet_ids             = module.vpc1.private_subnets
      appliance_mode_support = "disable"
      dns_support            = "enable"
      ipv6_support           = "disable"
      tags                   = {}
      vpc_routes = [
        {
          # name used as for_each key
          name                        = "route-foo1-${local.id}"
          route_table_id              = module.vpc1.private_route_table_ids[0]
          destination_cidr_block      = "10.1.0.0/24"
          destination_ipv6_cidr_block = null
        }
      ]
      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false
      transit_gateway_route_table_association         = "foo-${local.id}"
      transit_gateway_route_table_propagations = [
        "foo-${local.id}",
        "bar-${local.id}",
      ]
    },
    {
      name                   = "bar-${local.id}"
      subnet_ids             = module.vpc2.private_subnets
      appliance_mode_support = "disable"
      dns_support            = "enable"
      ipv6_support           = "disable"
      tags                   = {}
      vpc_routes = [
        {
          name                        = "route-bar1-${local.id}"
          route_table_id              = module.vpc2.private_route_table_ids[0]
          destination_cidr_block      = "10.0.0.0/24"
          destination_ipv6_cidr_block = null
        }
      ]
      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = true
      transit_gateway_route_table_association         = null
      transit_gateway_route_table_propagations        = []
    },
  ]
}

module "vpc1" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v5.1.0"

  name            = "tardigrade-testing-vpc1-${local.id}"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "vpc2" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v5.1.1"

  name            = "tardigrade-testing-vpc2-${local.id}"
  cidr            = "10.1.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

output "tgw" {
  value = module.tgw
}
