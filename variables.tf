variable "create_tgw_attachment" {
  description = "Controls whether to create the TGW attachment"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the TGW attachment for tagging purposes"
  type        = string
  default     = null
}

variable "dns_support" {
  description = "(Optional) Whether DNS support is enabled. Valid values: disable, enable."
  type        = string
  default     = "enable"
}

variable "owner_routes" {
  description = "List of AWS route objects to create with the \"owner\" provider. Each route will be created with a target of the transit gateway."
  type = list(object({
    route_table_id              = string
    destination_cidr_block      = string
    destination_ipv6_cidr_block = string
  }))
  default = []
}

variable "routes" {
  description = "List of AWS route objects to create with the \"aws\" provider. Each route will be created with a target of the transit gateway."
  type = list(object({
    route_table_id              = string
    destination_cidr_block      = string
    destination_ipv6_cidr_block = string
  }))
  default = []
}

variable "subnet_ids" {
  description = "A list of subnets inside the VPC"
  type        = list
  default     = []
}

variable "transit_gateway_id" {
  description = "The ID of the Transit Gateway"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC ID to attach to the TGW"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to apply to the TGW attachment"
  type        = map
  default     = {}
}
