output "peering_attachment" {
  description = "Object with the Transit Gateway peering attachment attributes"
  value       = module.peering_attachment.peering_attachment
}

output "peering_accepter" {
  description = "Object with the Transit Gateway peering attachment accepter attributes"
  value       = module.peering_accepter.peering_attachment_accepter
}
