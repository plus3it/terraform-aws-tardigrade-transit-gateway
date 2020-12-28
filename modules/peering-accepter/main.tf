resource "aws_ec2_transit_gateway_peering_attachment_accepter" "this" {
  transit_gateway_attachment_id = var.peering_attachment_id

  tags = var.tags
}
