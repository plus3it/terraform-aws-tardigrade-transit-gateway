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

variable "tags" {
  description = "Map of tags to apply to the TGW peering attachments"
  type        = map(string)
  default     = {}
}
