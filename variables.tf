###########################
## TGW Attachment Variables
###########################

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

##################
## Route Variables
##################
variable "vpc_cidr_remote" {
  description = "The remote CIDR block of the VPC route"
  type        = string
  default     = null
}

variable "vpc_cidr_local" {
  description = "The local CIDR block of the VPC route"
  type        = string
  default     = null
}

variable "private_route_tables" {
  description = "List of IDs of local private route tables to route to the remote VPC CIDR"
  type        = list(string)
  default     = []
}

variable "public_route_tables" {
  description = "List of IDs of local public route tables to route to the remote VPC CIDR"
  type        = list(string)
  default     = []
}

variable "remote_route_tables" {
  description = "List of IDs of remote route tables to route to the local VPC CIDR"
  type        = list(string)
  default     = []
}
