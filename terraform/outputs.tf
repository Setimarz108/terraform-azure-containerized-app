# Main configuration outputs

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "frontend_url" {
  description = "Frontend application URL"
  value       = module.container_apps.frontend_url
}

output "backend_url" {
  description = "Backend API URL"
  value       = module.container_apps.backend_url
}

output "database_server" {
  description = "Database server name"
  value       = module.database.server_name
}

# Summary of what was created
output "deployment_summary" {
  description = "Summary of the deployment"
  value = {
    resource_group = azurerm_resource_group.main.name
    location       = var.location
    environment    = var.environment
    frontend_url   = module.container_apps.frontend_url
    backend_url    = module.container_apps.backend_url
  }
}