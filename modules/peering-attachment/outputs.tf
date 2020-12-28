output "peering_attachment" {
  description = "Object with the Transit Gateway peering attachment attributes"
  value       = aws_ec2_transit_gateway_peering_attachment.this
}
