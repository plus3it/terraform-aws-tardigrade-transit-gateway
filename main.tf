resource "aws_ec2_transit_gateway" "this" {
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  description                     = var.description
  dns_support                     = var.dns_support
  tags                            = var.tags
  vpn_ecmp_support                = var.vpn_ecmp_support
}

module "route_tables" {
  source   = "./modules/route-table"
  for_each = { for route_table in var.route_tables : route_table.name => route_table }

  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = merge(
    { "Name" : each.key },
    each.value.tags,
  )
}

module "routes" {
  source   = "./modules/route"
  for_each = { for route in var.routes : route.name => route }

  blackhole              = each.value.blackhole
  destination_cidr_block = each.value.destination_cidr_block

  transit_gateway_route_table_id = each.value.default_route_table ? (
    aws_ec2_transit_gateway.this.association_default_route_table_id) : (
    try(
      module.route_tables[each.value.transit_gateway_route_table].route_table.id,
      each.value.transit_gateway_route_table
    )
  )

  transit_gateway_attachment_id = try(
    module.vpc_attachments[each.value.transit_gateway_attachment].vpc_attachment.id,
    each.value.transit_gateway_attachment
  )
}

module "vpc_attachments" {
  source   = "./modules/vpc-attachment"
  for_each = { for attachment in var.vpc_attachments : attachment.name => attachment }

  subnet_ids         = each.value.subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  dns_support        = each.value.dns_support
  ipv6_support       = each.value.ipv6_support
  vpc_routes         = each.value.vpc_routes

  transit_gateway_default_route_table_association = each.value.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = each.value.transit_gateway_default_route_table_propagation

  transit_gateway_route_table_association = each.value.transit_gateway_route_table_association == null ? null : {
    transit_gateway_route_table_id = try(
      module.route_tables[each.value.transit_gateway_route_table_association].route_table.id,
      each.value.transit_gateway_route_table_association
    )
  }

  transit_gateway_route_table_propagations = [for route_table in each.value.transit_gateway_route_table_propagations : {
    name = route_table
    transit_gateway_route_table_id = try(
      module.route_tables[route_table].route_table.id,
      route_table
    )
  }]

  tags = merge(
    { "Name" : each.key },
    each.value.tags,
  )
}
