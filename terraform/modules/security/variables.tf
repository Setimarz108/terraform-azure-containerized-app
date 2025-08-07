# Inputs this security module needs

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "container_nsg_name" {
  description = "Name of the container security group"
  type        = string
}

variable "database_nsg_name" {
  description = "Name of the database security group"
  type        = string
}

variable "container_subnet_id" {
  description = "ID of the container subnet"
  type        = string
}

variable "database_subnet_id" {
  description = "ID of the database subnet"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}