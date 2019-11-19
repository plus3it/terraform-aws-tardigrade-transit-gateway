provider "aws" {}

provider "aws" {
  alias = "owner"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = var.create_tgw_attachment ? 1 : 0

  provider = "aws"

  subnet_ids         = var.subnet_ids
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = var.vpc_id
  dns_support        = var.dns_support
  tags               = merge(var.tags, map("Name", var.name))
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "this" {
  count = var.create_tgw_attachment ? 1 : 0

  provider = "aws.owner"

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.this[0].id
  tags                          = merge(var.tags, map("Name", var.name))
}

# TGW Owner route table route to the local VPC CIDR
resource "aws_route" "remote" {
  provider = "aws.owner"
  count    = var.create_tgw_attachment ? length(var.remote_route_tables) : 0

  route_table_id         = var.remote_route_tables[count.index]
  destination_cidr_block = var.vpc_cidr_local
  transit_gateway_id     = var.transit_gateway_id
}

# Public route table route to the TGW for a remote CIDR
resource "aws_route" "public" {
  provider = "aws"
  count    = var.create_tgw_attachment ? length(var.public_route_tables) : 0

  route_table_id         = var.public_route_tables[count.index]
  destination_cidr_block = var.vpc_cidr_remote
  transit_gateway_id     = var.transit_gateway_id
}

# Private route table route to the TGW for a remote CIDR
resource "aws_route" "private" {
  provider = "aws"
  count    = var.create_tgw_attachment ? length(var.private_route_tables) : 0

  route_table_id         = var.private_route_tables[count.index]
  destination_cidr_block = var.vpc_cidr_remote
  transit_gateway_id     = var.transit_gateway_id
}