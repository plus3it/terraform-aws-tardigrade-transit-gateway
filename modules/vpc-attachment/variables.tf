variable "subnet_ids" {
  description = "List of subnets to associate with the VPC attachment"
  type        = list(string)
}

variable "transit_gateway_id" {
  description = "ID of the Transit Gateway"
  type        = string
}

variable "cross_account" {
  description = "Boolean whether this is a cross-account Transit Gateway shared via Resource Access Manager"
  type        = bool
  default     = false
}

variable "dns_support" {
  description = "Whether DNS support is enabled. Valid values: disable, enable"
  type        = string
  default     = "enable"
  validation {
    condition     = contains(["enable", "disable"], var.dns_support)
    error_message = "`dns_support` must be one of: \"enable\", \"disable\"."
  }
}

variable "ipv6_support" {
  description = "Whether IPv6 support is enabled. Valid values: disable, enable"
  type        = string
  default     = "disable"
  validation {
    condition     = contains(["enable", "disable"], var.ipv6_support)
    error_message = "`ipv6_support` must be one of: \"enable\", \"disable\"."
  }
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

variable "tags" {
  description = "Map of tags to apply to the TGW VPC attachment"
  type        = map(string)
  default     = {}
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
