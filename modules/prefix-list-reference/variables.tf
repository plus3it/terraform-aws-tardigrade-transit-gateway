variable "prefix_list_id" {
  description = "ID of the prefix list to reference"
  type        = string
  nullable    = false
}

variable "transit_gateway_route_table_id" {
  description = "ID of the route table to associate with the prefix list"
  type        = string
  nullable    = false
}

variable "blackhole" {
  description = "Boolean indicating whether to drop traffic that matches this prefix list"
  type        = bool
  default     = false
  nullable    = false
}

variable "transit_gateway_attachment_id" {
  description = "ID of the attachment to associate with the prefix list"
  type        = string
  default     = null
}
