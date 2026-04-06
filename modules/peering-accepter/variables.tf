variable "peering_attachment_id" {
  description = "ID of the TGW peering attachment"
  type        = string
}

variable "region" {
  description = "AWS region where the Transit Gateway is located (if different from the provider region)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to apply to the TGW peering attachment"
  type        = map(string)
  default     = {}
}

variable "transit_gateway_route_table_association" {
  description = "ID of the Transit Gateway route table to associate with the Peering attachment (an attachment can be associated with a single TGW route table)"
  type = object({
    transit_gateway_route_table_id = string
  })
  default = null
}
