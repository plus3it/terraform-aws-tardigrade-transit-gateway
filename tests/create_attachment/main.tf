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

resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
  number  = false
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.15.0"

  providers = {
    aws = aws
  }

  name            = "tardigrade-tgw-${random_string.this.result}"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "create_attachment" {
  source = "../../"

  providers = {
    aws       = "aws"
    aws.owner = "aws.owner"
  }

  create_tgw_attachment = true
  name                  = "tardigrade-tgw-${random_string.this.result}"
  subnet_ids            = module.vpc.private_subnets
  transit_gateway_id    = data.terraform_remote_state.prereq.outputs.tgw_id
  vpc_id                = module.vpc.vpc_id
}
