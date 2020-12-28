variable "peering_attachment_id" {
  description = "ID of the TGW peering attachment"
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to the TGW peering attachment"
  type        = map(string)
  default     = {}
}
