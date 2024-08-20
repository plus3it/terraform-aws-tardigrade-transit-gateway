variable "transit_gateway_id" {
  description = "ID of the Transit Gateway"
  type        = string
}

variable "peer_region" {
  description = "Region of EC2 Transit Gateway to peer with"
  type        = string
}

variable "peer_transit_gateway_id" {
  description = "ID of the Transit Gateway to peer with"
  type        = string
}

variable "peer_account_id" {
  description = "ID of the AWS account that owns the Transit Gateway peer"
  type        = string
  default     = null
}

variable "peer_transit_gateway_route_table_association" {
  description = "ID of the Peer Transit Gateway route table to associate with the Peering attachment (an attachment can be associated with a single TGW route table)"
  type = object({
    transit_gateway_route_table_id = string
  })
  default = null
}

variable "options" {
  description = "Object of options for the TGW peering attachment"
  type = object({
    dynamic_routing = optional(string)
  })
  default = null

  validation {
    condition     = var.options != null && try(var.options.dynamic_routing, null) != null ? contains(["enable", "disable"], var.options.dynamic_routing) : true
    error_message = "`var.options.dynamic_routing` must be one of: \"enable\", \"disable\"."
  }
}

variable "tags" {
  description = "Map of tags to apply to the TGW peering attachments"
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
