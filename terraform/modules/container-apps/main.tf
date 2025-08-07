# This module creates the container instances for our applications

# Backend Container (Node.js API)
resource "azurerm_container_group" "backend" {
  name                = var.backend_container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"                    # Gets a public IP
  dns_name_label      = var.backend_dns_label       # Gets a public URL
  os_type             = "Linux"
  # REMOVED: subnet_ids - Can't use with dns_name_label
  restart_policy      = "Always"                    # Restart if it crashes
  
  container {
    name   = "backend"
    image  = var.backend_image                      # Your Docker image
    cpu    = "0.5"                                  # Half a CPU core
    memory = "1.0"                                  # 1GB RAM
    
    ports {
      port     = 3000                               # Port the API runs on
      protocol = "TCP"
    }
    
    # Regular environment variables
    environment_variables = {
      NODE_ENV = "production"
      PORT     = "3000"
    }
    
    # Secret environment variables (database connection)
    secure_environment_variables = var.backend_secure_environment_variables
  }
  
  tags = var.tags
}

# Frontend Container (React app)
resource "azurerm_container_group" "frontend" {
  name                = var.frontend_container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"                    # Gets a public IP
  dns_name_label      = var.frontend_dns_label      # Gets a public URL
  os_type             = "Linux"
  # REMOVED: subnet_ids - Can't use with dns_name_label
  restart_policy      = "Always"                    # Restart if it crashes
  
  container {
    name   = "frontend"
    image  = var.frontend_image                     # Your Docker image
    cpu    = "0.5"                                  # Half a CPU core
    memory = "1.0"                                  # 1GB RAM
    
    ports {
      port     = 80                                 # Port the web app runs on
      protocol = "TCP"
    }
    
    # Tell the frontend where to find the backend API
    environment_variables = {
      REACT_APP_API_URL = var.backend_api_url
    }
  }
  
  tags = var.tags
}