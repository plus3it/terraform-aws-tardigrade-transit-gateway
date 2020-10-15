provider aws {
  region  = "us-east-1"
  profile = "resource-member"
}

provider aws {
  region  = "us-east-2"
  alias   = "peer"
  profile = "resource-owner"
}

module peering_attachment {
  source = "../../modules/cross-region-peering-attachment"

  providers = {
    aws      = aws
    aws.peer = aws.peer
  }

  peer_account_id         = data.aws_caller_identity.peer.account_id
  peer_region             = data.aws_region.peer.name
  peer_transit_gateway_id = module.tgw_peer.transit_gateway.id
  transit_gateway_id      = module.tgw.transit_gateway.id

  tags = {
    Name = "tardigrade-testing-${local.id}"
  }
}

module tgw {
  source = "../.."

  description = "tardigrade-tgw-${local.id}"

  tags = {
    Name = "tardigrade-testing-${local.id}"
  }
}

module tgw_peer {
  source = "../.."
  providers = {
    aws = aws.peer
  }

  description = "tardigrade-tgw-${local.id}"

  tags = {
    Name = "tardigrade-testing-${local.id}"
  }
}


locals {
  id = data.terraform_remote_state.prereq.outputs.test_id.result
}

data terraform_remote_state prereq {
  backend = "local"
  config = {
    path = "prereq/terraform.tfstate"
  }
}

data aws_caller_identity peer {
  provider = aws.peer
}

data aws_region peer {
  provider = aws.peer
}

output peering_attachment {
  value = module.peering_attachment
}
