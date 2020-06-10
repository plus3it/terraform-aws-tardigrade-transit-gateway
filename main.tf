provider "aws" {}

provider "aws" {
  alias = "owner"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = var.create_tgw_attachment ? 1 : 0

  provider = aws

  subnet_ids         = var.subnet_ids
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = var.vpc_id
  dns_support        = var.dns_support
  tags               = merge(var.tags, map("Name", var.name))

  depends_on = [null_resource.dependencies]
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "this" {
  count = local.create_tgw_accepter ? 1 : 0

  provider = aws.owner

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.this[0].id
  tags                          = merge(var.tags, map("Name", var.name))
}

resource "aws_route" "this" {
  count = var.create_tgw_attachment ? length(var.routes) : 0

  provider = aws

  route_table_id              = var.routes[count.index].route_table_id
  destination_cidr_block      = var.routes[count.index].destination_cidr_block
  destination_ipv6_cidr_block = var.routes[count.index].destination_ipv6_cidr_block
  transit_gateway_id          = local.transit_gateway_id
}

resource "aws_route" "owner" {
  count = var.create_tgw_attachment ? length(var.owner_routes) : 0

  provider = aws.owner

  route_table_id              = var.owner_routes[count.index].route_table_id
  destination_cidr_block      = var.owner_routes[count.index].destination_cidr_block
  destination_ipv6_cidr_block = var.owner_routes[count.index].destination_ipv6_cidr_block
  transit_gateway_id          = local.transit_gateway_id
}

resource "null_resource" "dependencies" {
  count = var.create_tgw_attachment ? 1 : 0

  triggers = {
    this = join(",", var.dependencies)
  }
}

data "aws_caller_identity" "this" {
  count = var.create_tgw_attachment ? 1 : 0
}

data "aws_caller_identity" "owner" {
  count = var.create_tgw_attachment ? 1 : 0

  provider = aws.owner
}

locals {
  create_tgw_accepter = var.create_tgw_attachment ? data.aws_caller_identity.this[0].account_id != data.aws_caller_identity.owner[0].account_id : false

  transit_gateway_id = var.create_tgw_attachment ? (
    local.create_tgw_accepter ? aws_ec2_transit_gateway_vpc_attachment_accepter.this[0].transit_gateway_id : aws_ec2_transit_gateway_vpc_attachment.this[0].transit_gateway_id
  ) : false
}
