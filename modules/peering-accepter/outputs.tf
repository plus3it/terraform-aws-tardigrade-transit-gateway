output "peering_attachment_accepter" {
  description = "Object with the Transit Gateway peering attachment accepter attributes"
  value       = aws_ec2_transit_gateway_peering_attachment_accepter.this
}
