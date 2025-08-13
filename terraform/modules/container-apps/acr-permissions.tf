# Get ACR resource
data "azurerm_container_registry" "acr" {
  name                = "portfoliodev036df847"
  resource_group_name = var.resource_group_name
}

# Grant backend container identity ACR pull permissions
resource "azurerm_role_assignment" "backend_acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_container_group.backend.identity[0].principal_id
}

# Grant frontend container identity ACR pull permissions
resource "azurerm_role_assignment" "frontend_acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_container_group.frontend.identity[0].principal_id
}
