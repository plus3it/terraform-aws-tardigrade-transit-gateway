provider "aws" {
  alias = "peer"
}

module "peering_attachment" {
  source = "../peering-attachment"

  peer_account_id         = var.peer_account_id
  peer_region             = var.peer_region
  peer_transit_gateway_id = var.peer_transit_gateway_id
  transit_gateway_id      = var.transit_gateway_id
  tags                    = var.tags
}

module "peering_accepter" {
  source = "../peering-accepter"
  providers = {
    aws = aws.peer
  }

  peering_attachment_id = module.peering_attachment.peering_attachment.id

  tags = var.tags
}
