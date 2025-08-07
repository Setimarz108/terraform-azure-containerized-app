# Values this security module provides

output "container_nsg_id" {
  description = "ID of the container security group"
  value       = azurerm_network_security_group.containers.id
}

output "database_nsg_id" {
  description = "ID of the database security group"
  value       = azurerm_network_security_group.database.id
}