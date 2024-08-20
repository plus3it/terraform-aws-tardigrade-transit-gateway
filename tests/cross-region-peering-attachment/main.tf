provider "aws" {
  region  = "us-east-1"
  profile = "aws"
}

provider "aws" {
  region  = "us-east-2"
  alias   = "peer"
  profile = "awsalternate"
}

module "peering_attachment" {
  source = "../../modules/cross-region-peering-attachment"

  providers = {
    aws      = aws
    aws.peer = aws.peer
  }

  peer_account_id         = data.aws_caller_identity.peer.account_id
  peer_region             = data.aws_region.peer.name
  peer_transit_gateway_id = module.tgw_peer.transit_gateway.id
  transit_gateway_id      = module.tgw.transit_gateway.id

  peer_transit_gateway_route_table_association = {
    transit_gateway_route_table_id = module.tgw_peer.route_tables["tardigrade-testing-${local.id}"].route_table.id
  }

  transit_gateway_route_table_association = {
    transit_gateway_route_table_id = module.tgw.route_tables["tardigrade-testing-${local.id}"].route_table.id
  }

  # Although the API claims suport for the dynamic routing option, it will fail
  # if set to anything other than null. Leaving the option in place to match the
  # API spec, and to support future updates.
  options = null

  tags = {
    Name = "tardigrade-testing-${local.id}"
  }
}

module "tgw" {
  source = "../.."

  description = "tardigrade-tgw-${local.id}"

  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  route_tables = [
    {
      name = "tardigrade-testing-${local.id}"
      tags = {}
    },
  ]

  tags = {
    Name = "tardigrade-testing-${local.id}"
  }
}

module "tgw_peer" {
  source = "../.."
  providers = {
    aws = aws.peer
  }

  description = "tardigrade-tgw-${local.id}"

  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  route_tables = [
    {
      name = "tardigrade-testing-${local.id}"
      tags = {}
    },
  ]

  tags = {
    Name = "tardigrade-testing-${local.id}"
  }
}


locals {
  id = data.terraform_remote_state.prereq.outputs.test_id.result
}

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

data "aws_caller_identity" "peer" {
  provider = aws.peer
}

data "aws_region" "peer" {
  provider = aws.peer
}

output "peering_attachment" {
  value = module.peering_attachment
}
