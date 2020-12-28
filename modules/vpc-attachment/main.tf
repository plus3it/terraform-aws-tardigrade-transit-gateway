resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = var.subnet_ids
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = data.aws_subnet.one.vpc_id
  dns_support        = var.dns_support
  ipv6_support       = var.ipv6_support
  tags               = var.tags

  # default assocation and propagation values must be:
  #   `true` if transit gateway is owned by another account (shared using RAM)
  #   `false` if the transit gateway has no default route table (== "disable")
  transit_gateway_default_route_table_association = (
    var.cross_account) ? true : (
    data.aws_ec2_transit_gateway.this[0].default_route_table_association == "disable") ? false : (
    var.transit_gateway_default_route_table_association
  )

  transit_gateway_default_route_table_propagation = (
    var.cross_account) ? true : (
    data.aws_ec2_transit_gateway.this[0].default_route_table_propagation == "disable") ? false : (
    var.transit_gateway_default_route_table_propagation
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = var.transit_gateway_route_table_association != null ? 1 : 0

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = var.transit_gateway_route_table_association.transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each = { for route_table in var.transit_gateway_route_table_propagations : route_table.name => route_table }

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = each.value.transit_gateway_route_table_id
}

resource "aws_route" "this" {
  for_each = { for route in var.vpc_routes : route.name => route }

  route_table_id              = each.value.route_table_id
  destination_cidr_block      = each.value.destination_cidr_block
  destination_ipv6_cidr_block = each.value.destination_ipv6_cidr_block
  transit_gateway_id          = aws_ec2_transit_gateway_vpc_attachment.this.transit_gateway_id
}

data "aws_subnet" "one" {
  id = var.subnet_ids[0]
}

data "aws_ec2_transit_gateway" "this" {
  count = var.cross_account ? 0 : 1
  id    = var.transit_gateway_id
}
