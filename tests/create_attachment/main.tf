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

data "terraform_remote_state" "prereq" {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
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
  transit_gateway_id    = data.terraform_remote_state.prereq.outputs.tgw_id
  vpc_id                = module.vpc.vpc_id
}

locals {
  test_id          = data.terraform_remote_state.prereq.outputs.test_id
  remote_ipv4_cidr = "10.1.0.0/16"

  routes = [for rt in concat(module.vpc.public_route_table_ids, module.vpc.private_route_table_ids) :
    {
      route_table_id              = rt
      destination_cidr_block      = local.remote_ipv4_cidr
      destination_ipv6_cidr_block = null
    }
  ]
}
