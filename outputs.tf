output "transit_gateway_attachment_id" {
  description = "The ID of the Transit Gateway Attachment"
  value       = length(aws_ec2_transit_gateway_vpc_attachment.this) > 0 ? aws_ec2_transit_gateway_vpc_attachment.this[0].id : null
}
