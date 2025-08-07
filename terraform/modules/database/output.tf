# Values this database module provides to other modules

output "server_name" {
  description = "Name of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.main.name
}

output "server_fqdn" {
  description = "Full domain name of the database server"
  value       = azurerm_postgresql_flexible_server.main.fqdn
  sensitive   = true  # This is sensitive info
}

output "database_name" {
  description = "Name of the created database"
  value       = azurerm_postgresql_flexible_server_database.app.name
}

output "admin_username" {
  description = "Database admin username"
  value       = azurerm_postgresql_flexible_server.main.administrator_login
}