output "vpc_attachment" {
  description = "Object with the Transit Gateway VPC attachment attributes"
  value       = module.vpc_attachment.vpc_attachment
}

output "vpc_accepter" {
  description = "Object with the Transit Gateway VPC attachment accepter attributes"
  value       = module.vpc_accepter.vpc_attachment_accepter
}

output "route_table_association" {
  description = "Object with the Transit Gateway route table association attributes"
  value       = module.vpc_accepter.route_table_association
}

output "route_table_propagations" {
  description = "Map of Transit Gateway route table propagation objects"
  value       = module.vpc_accepter.route_table_propagations
}

output "routes" {
  description = "Map of Transit Gateway route objects"
  value       = module.routes
}

output "vpc_routes" {
  description = "Map of VPC route objects"
  value = merge(
    module.vpc_attachment.vpc_routes,
    module.vpc_accepter.vpc_routes,
  )
}
