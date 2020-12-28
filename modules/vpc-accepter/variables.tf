variable "transit_gateway_attachment_id" {
  description = "ID of the TGW attachment"
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to the TGW attachment"
  type        = map(string)
  default     = {}
}

variable "transit_gateway_default_route_table_association" {
  description = "Boolean whether the VPC Attachment should be associated to the Transit Gateway default route table"
  type        = bool
  default     = true
}

variable "transit_gateway_default_route_table_propagation" {
  description = "Boolean whether the VPC Attachment should propagate routes to the Transit Gateway propagation default route table"
  type        = bool
  default     = true
}

variable "transit_gateway_route_table_association" {
  description = "ID of the Transit Gateway route table to associate with the VPC attachment (an attachment can be associated with a single TGW route table)"
  type = object({
    transit_gateway_route_table_id = string
  })
  default = null
}

variable "transit_gateway_route_table_propagations" {
  description = "List of Transit Gateway route tables this VPC attachment will propagate routes to"
  type = list(object({
    # `name` is used as for_each key
    name                           = string
    transit_gateway_route_table_id = string
  }))
  default = []
}

variable "vpc_routes" {
  description = "List of VPC route objects with a target of the VPC attachment"
  type = list(object({
    # `name` is used as for_each key
    name                        = string
    route_table_id              = string
    destination_cidr_block      = string
    destination_ipv6_cidr_block = string
  }))
  default = []
}
