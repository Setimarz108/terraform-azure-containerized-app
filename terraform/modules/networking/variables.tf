# These are the inputs this module needs

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "location" {
  description = "Azure region (like East US)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group (like a folder for resources)"
  type        = string
}

variable "private_dns_zone_name" {
  description = "Name for the private DNS zone"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources (like labels)"
  type        = map(string)
  default     = {}
}