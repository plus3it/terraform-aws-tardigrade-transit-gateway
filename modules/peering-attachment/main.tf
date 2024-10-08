resource "aws_ec2_transit_gateway_peering_attachment" "this" {
  peer_account_id         = var.peer_account_id
  peer_region             = var.peer_region
  peer_transit_gateway_id = var.peer_transit_gateway_id
  transit_gateway_id      = var.transit_gateway_id
  tags                    = var.tags

  dynamic "options" {
    for_each = var.options != null ? [var.options] : []
    content {
      dynamic_routing = options.value.dynamic_routing
    }
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = var.transit_gateway_route_table_association != null ? 1 : 0

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.this.id
  transit_gateway_route_table_id = var.transit_gateway_route_table_association.transit_gateway_route_table_id
}
