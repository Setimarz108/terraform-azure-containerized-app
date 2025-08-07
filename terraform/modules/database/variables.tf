# Inputs this database module needs

variable "server_name" {
  description = "Name of the PostgreSQL server"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where database will be deployed"
  type        = string
}

variable "private_dns_zone_id" {
  description = "ID of the private DNS zone"
  type        = string
}

variable "admin_username" {
  description = "Database administrator username"
  type        = string
}

variable "admin_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true  # This marks it as secret
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}