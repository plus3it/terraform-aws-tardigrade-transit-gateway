output "vpc_attachment" {
  description = "Object with the Transit Gateway VPC attachment attributes"
  value       = aws_ec2_transit_gateway_vpc_attachment.this
}

output "route_table_association" {
  description = "Object with the Transit Gateway route table association attributes"
  value       = var.transit_gateway_route_table_association != null ? aws_ec2_transit_gateway_route_table_association.this[0] : null
}

output "route_table_propagations" {
  description = "Map of Transit Gateway route table propagation objects"
  value       = aws_ec2_transit_gateway_route_table_propagation.this
}

output "vpc_routes" {
  description = "Map of VPC route objects"
  value       = aws_route.this
}
