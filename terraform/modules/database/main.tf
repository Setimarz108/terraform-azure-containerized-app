# PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "main" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "13"
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = var.private_dns_zone_id
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  
  # Don't specify zone - let Azure choose
  # zone = null  # Remove or comment out any zone specification
  
  # Disable public network access
  public_network_access_enabled = false
  
  # Free tier configuration
  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768
  
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  
  tags = var.tags

  # Ignore zone changes to prevent conflicts
  lifecycle {
    ignore_changes = [
      zone,
      high_availability
    ]
  }
}

# Database inside the server
resource "azurerm_postgresql_flexible_server_database" "app" {
  name      = "portfoliodb"
  server_id = azurerm_postgresql_flexible_server.main.id
  collation = "en_US.utf8"
  charset   = "utf8"
}