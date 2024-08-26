output "route" {
  description = "Object with the Transit Gateway prefix list reference attributes"
  value       = aws_ec2_transit_gateway_prefix_list_reference.this
}
