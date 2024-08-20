resource "aws_ec2_transit_gateway_peering_attachment_accepter" "this" {
  transit_gateway_attachment_id = var.peering_attachment_id

  tags = var.tags
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = var.transit_gateway_route_table_association != null ? 1 : 0

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.this.id
  transit_gateway_route_table_id = var.transit_gateway_route_table_association.transit_gateway_route_table_id
}
