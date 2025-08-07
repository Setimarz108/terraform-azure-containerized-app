# Values this container module provides

output "backend_url" {
  description = "Full URL of the backend API"
  value       = "http://${azurerm_container_group.backend.fqdn}:3000"
}

output "frontend_url" {
  description = "Full URL of the frontend website"
  value       = "http://${azurerm_container_group.frontend.fqdn}"
}

output "backend_fqdn" {
  description = "Domain name of the backend"
  value       = azurerm_container_group.backend.fqdn
}

output "frontend_fqdn" {
  description = "Domain name of the frontend"
  value       = azurerm_container_group.frontend.fqdn
}