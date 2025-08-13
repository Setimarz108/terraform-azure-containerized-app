# Main configuration inputs

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "portfolio"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

# Database configuration
variable "db_admin_username" {
  description = "Database administrator username"
  type        = string
  default     = "portfolioadmin"
}

variable "db_admin_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

# Container images
variable "backend_image" {
  description = "Backend container image"
  type        = string
  default     = "setimarziano/portfolio-backend:latest"
}

variable "frontend_image" {
  description = "Frontend container image"
  type        = string
  default     = "setimarziano/portfolio-frontend:latest"
}

variable "registry_username" {
  description = "ACR service principal username"
  type        = string
}

variable "registry_password" {
  description = "ACR service principal password"
  type        = string
  sensitive   = true
}