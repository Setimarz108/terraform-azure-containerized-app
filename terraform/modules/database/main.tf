# This module creates the PostgreSQL database

# PostgreSQL Flexible Server (the actual database server)
resource "azurerm_postgresql_flexible_server" "main" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "13"                        # PostgreSQL version
  delegated_subnet_id    = var.subnet_id              # Where to put the database
  private_dns_zone_id    = var.private_dns_zone_id    # Private DNS for security
  administrator_login    = var.admin_username         # Database username
  administrator_password = var.admin_password         # Database password
  
 
  public_network_access_enabled = false
  
  # Free tier configuration (B1ms = 1 CPU, 2GB RAM)
  sku_name   = "B_Standard_B1ms"  
  storage_mb = 32768              # 32GB storage (free tier limit)
  
  backup_retention_days = 7       # Keep backups for 7 days
  
  tags = var.tags
}

# Create the actual database inside the server
resource "azurerm_postgresql_flexible_server_database" "app" {
  name      = "portfoliodb"                           # Database name
  server_id = azurerm_postgresql_flexible_server.main.id
  collation = "en_US.utf8"                           # Text sorting rules
  charset   = "utf8"                                 # Character encoding
}