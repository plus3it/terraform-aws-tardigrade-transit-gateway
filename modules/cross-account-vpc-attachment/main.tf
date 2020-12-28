provider "aws" {
  alias = "owner"
}

module "vpc_attachment" {
  source = "../vpc-attachment"

  subnet_ids         = var.subnet_ids
  transit_gateway_id = var.transit_gateway_id
  cross_account      = true
  dns_support        = var.dns_support
  ipv6_support       = var.ipv6_support
  vpc_routes         = [for route in var.vpc_routes : route if route.provider == "aws"]

  tags = merge(
    {
      ram_share_id                = var.ram_share_id
      ram_resource_association_id = var.ram_resource_association_id
    },
    var.tags,
  )
}

module "vpc_accepter" {
  source = "../vpc-accepter"
  providers = {
    aws = aws.owner
  }

  transit_gateway_attachment_id = module.vpc_attachment.vpc_attachment.id
  vpc_routes                    = [for route in var.vpc_routes : route if route.provider == "aws.owner"]
  tags                          = var.tags

  transit_gateway_route_table_association  = var.transit_gateway_route_table_association
  transit_gateway_route_table_propagations = var.transit_gateway_route_table_propagations

  # default assocation and propagation values must be:
  #   `false` if the transit gateway has no default route table (== "disable")
  transit_gateway_default_route_table_association = (
    data.aws_ec2_transit_gateway.this.default_route_table_association == "disable") ? false : (
    var.transit_gateway_default_route_table_association
  )

  transit_gateway_default_route_table_propagation = (
    data.aws_ec2_transit_gateway.this.default_route_table_propagation == "disable") ? false : (
    var.transit_gateway_default_route_table_propagation
  )
}

module "routes" {
  source   = "../route"
  for_each = { for route in var.routes : route.name => route }
  providers = {
    aws = aws.owner
  }

  destination_cidr_block         = each.value.destination_cidr_block
  transit_gateway_attachment_id  = module.vpc_accepter.vpc_attachment_accepter.id
  transit_gateway_route_table_id = each.value.transit_gateway_route_table_id
}

data "aws_ec2_transit_gateway" "this" {
  provider = aws.owner
  id       = var.transit_gateway_id
}
