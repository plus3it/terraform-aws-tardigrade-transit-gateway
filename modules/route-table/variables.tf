variable "transit_gateway_id" {
  description = "ID of EC2 Transit Gateway"
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to the TGW route table"
  type        = map(string)
  default     = {}
}
