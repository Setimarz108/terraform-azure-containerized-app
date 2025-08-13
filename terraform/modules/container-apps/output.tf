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

# Output managed identity information
output "backend_identity_principal_id" {
  description = "Principal ID of backend managed identity"
  value       = azurerm_container_group.backend.identity[0].principal_id
}

output "frontend_identity_principal_id" {
  description = "Principal ID of frontend managed identity"
  value       = azurerm_container_group.frontend.identity[0].principal_id
}