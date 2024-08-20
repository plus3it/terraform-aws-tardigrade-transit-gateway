output "peering_attachment" {
  description = "Object with the Transit Gateway peering attachment attributes"
  value       = aws_ec2_transit_gateway_peering_attachment.this
}

output "route_table_association" {
  description = "Object with the Transit Gateway route table association attributes"
  value       = var.transit_gateway_route_table_association != null ? aws_ec2_transit_gateway_route_table_association.this[0] : null
}
