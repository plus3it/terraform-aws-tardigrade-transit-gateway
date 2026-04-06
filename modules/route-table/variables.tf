variable "transit_gateway_id" {
  description = "ID of EC2 Transit Gateway"
  type        = string
}

variable "region" {
  description = "AWS region where the Transit Gateway is located (if different from the provider region)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to apply to the TGW route table"
  type        = map(string)
  default     = {}
}
