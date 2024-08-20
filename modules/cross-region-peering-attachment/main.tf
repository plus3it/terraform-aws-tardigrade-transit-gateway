module "peering_attachment" {
  source = "../peering-attachment"

  transit_gateway_id      = var.transit_gateway_id
  peer_transit_gateway_id = var.peer_transit_gateway_id
  peer_region             = var.peer_region

  options         = var.options
  peer_account_id = var.peer_account_id
  tags            = var.tags

  # Associate the Peering attachment with a TGW route table, while establishing
  # a depenency between the accepter and the association
  transit_gateway_route_table_association = var.transit_gateway_route_table_association != null ? {
    transit_gateway_attachment_id  = module.peering_accepter.peering_attachment_accepter.id
    transit_gateway_route_table_id = var.transit_gateway_route_table_association.transit_gateway_route_table_id
  } : null
}

module "peering_accepter" {
  source = "../peering-accepter"

  providers = {
    aws = aws.peer
  }

  peering_attachment_id                   = module.peering_attachment.peering_attachment.id
  transit_gateway_route_table_association = var.peer_transit_gateway_route_table_association

  tags = var.tags
}
