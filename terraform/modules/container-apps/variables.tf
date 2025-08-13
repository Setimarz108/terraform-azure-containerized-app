# Inputs this container module needs

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for containers"
  type        = string
}

# Backend container settings
variable "backend_container_name" {
  description = "Name of the backend container group"
  type        = string
}

variable "backend_dns_label" {
  description = "DNS label for backend (creates the URL)"
  type        = string
}

variable "backend_image" {
  description = "Docker image for backend"
  type        = string
}

variable "backend_secure_environment_variables" {
  description = "Secret environment variables for backend (like database password)"
  type        = map(string)
  default     = {}
  sensitive   = true
}

# Frontend container settings
variable "frontend_container_name" {
  description = "Name of the frontend container group"
  type        = string
}

variable "frontend_dns_label" {
  description = "DNS label for frontend (creates the URL)"
  type        = string
}

variable "frontend_image" {
  description = "Docker image for frontend"
  type        = string
}

variable "backend_api_url" {
  description = "URL where frontend can reach the backend"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}


# Registry credentials for ACR access
variable "registry_server" {
  description = "Container registry server"
  type        = string
}

variable "registry_username" {
  description = "Container registry username"
  type        = string
}

variable "registry_password" {
  description = "Container registry password"
  type        = string
  sensitive   = true
}
