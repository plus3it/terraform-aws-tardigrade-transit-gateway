output "transit_gateway" {
  description = "Object with attributes of the Transit Gateway"
  value       = aws_ec2_transit_gateway.this
}

output "vpc_attachments" {
  description = "Map of TGW peering attachment objects"
  value       = module.vpc_attachments
}

output "route_tables" {
  description = "Map of TGW route table objects"
  value       = module.route_tables
}

output "routes" {
  description = "Map of TGW route objects"
  value       = module.routes
}
