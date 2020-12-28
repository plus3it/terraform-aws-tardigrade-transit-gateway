resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "this" {
  transit_gateway_attachment_id = var.transit_gateway_attachment_id

  transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation

  tags = var.tags
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = var.transit_gateway_route_table_association != null ? 1 : 0

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment_accepter.this.id
  transit_gateway_route_table_id = var.transit_gateway_route_table_association.transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each = { for route_table in var.transit_gateway_route_table_propagations : route_table.name => route_table }

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment_accepter.this.id
  transit_gateway_route_table_id = each.value.transit_gateway_route_table_id
}

resource "aws_route" "this" {
  for_each = { for route in var.vpc_routes : route.name => route }

  route_table_id              = each.value.route_table_id
  destination_cidr_block      = each.value.destination_cidr_block
  destination_ipv6_cidr_block = each.value.destination_ipv6_cidr_block
  transit_gateway_id          = aws_ec2_transit_gateway_vpc_attachment_accepter.this.transit_gateway_id
}
