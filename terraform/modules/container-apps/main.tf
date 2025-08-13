# Backend Container with Registry Credentials and Managed Identity
resource "azurerm_container_group" "backend" {
  name                = var.backend_container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = var.backend_dns_label
  os_type             = "Linux"
  restart_policy      = "Always"

  # Registry credentials for ACR access during image pull
  image_registry_credential {
    server   = var.registry_server
    username = var.registry_username
    password = var.registry_password
  }

  # Enable system-assigned managed identity for runtime operations
  identity {
    type = "SystemAssigned"
  }

  container {
    name   = "backend"
    image  = var.backend_image
    cpu    = "0.5"
    memory = "1.0"
    
    ports {
      port     = 3000
      protocol = "TCP"
    }
    
    environment_variables = {
      NODE_ENV = "production"
      PORT     = "3000"
    }
    
    secure_environment_variables = var.backend_secure_environment_variables
  }
  
  tags = var.tags
}

# Frontend Container with Registry Credentials and Managed Identity
resource "azurerm_container_group" "frontend" {
  name                = var.frontend_container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = var.frontend_dns_label
  os_type             = "Linux"
  restart_policy      = "Always"

  # Registry credentials for ACR access during image pull
  image_registry_credential {
    server   = var.registry_server
    username = var.registry_username
    password = var.registry_password
  }

  # Enable system-assigned managed identity for runtime operations
  identity {
    type = "SystemAssigned"
  }

  container {
    name   = "frontend"
    image  = var.frontend_image
    cpu    = "0.5"
    memory = "1.0"
    
    ports {
      port     = 80
      protocol = "TCP"
    }
    
    environment_variables = {
      REACT_APP_API_URL = var.backend_api_url
    }
  }
  
  tags = var.tags
}