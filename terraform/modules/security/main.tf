# This module creates security rules (firewalls) for our infrastructure

# Security rules for containers (what traffic is allowed in)
resource "azurerm_network_security_group" "containers" {
  name                = var.container_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Allow HTTP traffic (port 80) from anywhere
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow API traffic (port 3000) from anywhere
  security_rule {
    name                       = "AllowAPI"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Security rules for database (more restrictive)
resource "azurerm_network_security_group" "database" {
  name                = var.database_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Only allow database traffic (port 5432) from container subnet
  security_rule {
    name                       = "AllowPostgreSQL"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefixes    = ["10.0.1.0/24"]  # Only from container subnet
    destination_address_prefix = "*"
  }

  # Block everything else
  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Apply container security rules to container subnet
resource "azurerm_subnet_network_security_group_association" "containers" {
  subnet_id                 = var.container_subnet_id
  network_security_group_id = azurerm_network_security_group.containers.id
}

# Apply database security rules to database subnet
resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = var.database_subnet_id
  network_security_group_id = azurerm_network_security_group.database.id
}