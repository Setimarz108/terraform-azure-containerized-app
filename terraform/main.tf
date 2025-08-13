# This is the main configuration that uses all our modules

# Generate a random suffix for unique resource names
resource "random_id" "suffix" {
  byte_length = 4
}

# Common values used throughout
locals {
  resource_suffix = random_id.suffix.hex
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = "setimarz108"
  }
}

# Create the resource group (like a folder for all resources)
resource "azurerm_resource_group" "main" {
  name     = "${var.project_name}-${var.environment}-rg-${local.resource_suffix}"
  location = var.location
  tags     = local.common_tags
}

# Use the networking module
module "networking" {
  source = "./modules/networking"
  
  vnet_name             = "${var.project_name}-vnet-${local.resource_suffix}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = "${var.project_name}-postgres-${local.resource_suffix}.private.postgres.database.azure.com"
  tags                  = local.common_tags
}

# Use the security module
module "security" {
  source = "./modules/security"
  
  location              = var.location
  resource_group_name   = azurerm_resource_group.main.name
  container_nsg_name    = "${var.project_name}-containers-nsg-${local.resource_suffix}"
  database_nsg_name     = "${var.project_name}-database-nsg-${local.resource_suffix}"
  container_subnet_id   = module.networking.container_subnet_id
  database_subnet_id    = module.networking.database_subnet_id
  tags                  = local.common_tags
  
  # This module depends on networking being created first
  depends_on = [module.networking]
}

# Use the database module
module "database" {
  source = "./modules/database"
  
  server_name         = "${var.project_name}-postgres-${local.resource_suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  subnet_id           = module.networking.database_subnet_id
  private_dns_zone_id = module.networking.private_dns_zone_id
  admin_username      = var.db_admin_username
  admin_password      = var.db_admin_password
  tags                = local.common_tags
  
  # This module depends on networking being created first
  depends_on = [module.networking]
}

# Use the container-apps module
module "container_apps" {
  source = "./modules/container-apps"
  
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.networking.container_subnet_id
  
  # Backend configuration
  backend_container_name = "${var.project_name}-backend-${local.resource_suffix}"
  backend_dns_label      = "${var.project_name}-backend-${local.resource_suffix}"
  backend_image          = var.backend_image
  backend_secure_environment_variables = {
    DB_HOST     = module.database.server_fqdn
    DB_NAME     = module.database.database_name
    DB_USER     = var.db_admin_username
    DB_PASSWORD = var.db_admin_password
  }
  
  # Frontend configuration  
  frontend_container_name = "${var.project_name}-frontend-${local.resource_suffix}"
  frontend_dns_label      = "${var.project_name}-frontend-${local.resource_suffix}"
  frontend_image          = var.frontend_image
  backend_api_url         = "http://portfolio-backend-${local.resource_suffix}.eastus.azurecontainer.io:3000"
  
  tags = local.common_tags
  
  # This module depends on networking and database being created first
  depends_on = [module.networking, module.database, module.security]
}