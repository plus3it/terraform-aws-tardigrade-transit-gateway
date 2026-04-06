resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = var.transit_gateway_id
  region             = var.region
  tags               = var.tags
}
