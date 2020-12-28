output "route_table" {
  description = "Object with the Transit Gateway route table attributes"
  value       = aws_ec2_transit_gateway_route_table.this
}
