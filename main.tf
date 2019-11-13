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
  tags               = "${merge(var.tags, map("Name", var.name))}"
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "this" {
  count = var.create_tgw_attachment ? 1 : 0

  provider = "aws.owner"

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.this[0].id
  tags                          = "${merge(var.tags, map("Name", var.name))}"
}
