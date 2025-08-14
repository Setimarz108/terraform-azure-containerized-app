output "frontend_url" {
  description = "Frontend application URL"
  value       = "http://${module.container_apps.frontend_fqdn}"
}

output "backend_url" {
  description = "Backend API URL"
  value       = "http://${module.container_apps.backend_fqdn}:3000"
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_suffix" {
  description = "Random suffix used for resources"
  value       = local.resource_suffix
}

output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = module.acr.acr_name
}

output "acr_login_server" {
  description = "ACR login server"
  value       = module.acr.registry_login_server
}

output "acr_admin_username" {
  description = "ACR admin username"
  value       = module.acr.admin_username
}

output "deployment_summary" {
  description = "Summary of deployed resources"
  value = {
    resource_group = azurerm_resource_group.main.name
    frontend_url   = "http://${module.container_apps.frontend_fqdn}"
    backend_url    = "http://${module.container_apps.backend_fqdn}:3000"
    acr_name       = module.acr.acr_name
    acr_server     = module.acr.registry_login_server
    location       = var.location
    environment    = var.environment
  }
}
# Database outputs for debugging
output "database_server_fqdn" {
  description = "Database server FQDN"
  value       = module.database.server_fqdn
  sensitive   = true
}

output "database_name" {
  description = "Database name"
  value       = module.database.database_name
}

output "database_admin_username" {
  description = "Database admin username"
  value       = module.database.admin_username
}