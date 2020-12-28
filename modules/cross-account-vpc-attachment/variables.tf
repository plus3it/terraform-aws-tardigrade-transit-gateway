variable "ram_share_id" {
  description = "ID of the RAM Share associated with the Transit Gateway"
  type        = string
}

variable "ram_resource_association_id" {
  description = "ID of the RAM resource association for the Transit Gateway"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnets to associate with the VPC attachment"
  type        = list(string)
}

variable "transit_gateway_id" {
  description = "ID of the Transit Gateway"
  type        = string
}

variable "dns_support" {
  description = "Whether DNS support is enabled. Valid values: disable, enable."
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

variable "routes" {
  description = "List of TGW route objects with a target of the VPC attachment in the `aws.owner` account (TGW route tables are *only* in the `aws.owner` account)"
  type = list(object({
    # `name` is used as for_each key
    name                           = string
    destination_cidr_block         = string
    transit_gateway_route_table_id = string
  }))
  default = []
}

variable "tags" {
  description = "Map of tags to apply to the TGW attachments"
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
  description = "List of VPC route objects with a target of the transit gateway."
  type = list(object({
    # `name` is used as for_each key
    name                        = string
    provider                    = string
    route_table_id              = string
    destination_cidr_block      = string
    destination_ipv6_cidr_block = string
  }))
  default = []
  validation {
    condition     = length(setsubtract(var.vpc_routes[*].provider, ["aws", "aws.owner"])) == 0
    error_message = "The `provider` attribute for each VPC route must be one of: \"aws\", \"aws.owner\"."
  }
}
