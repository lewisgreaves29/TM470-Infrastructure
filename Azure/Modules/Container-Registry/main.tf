
resource "azurerm_container_registry" "uni_container_registry" {
  name                = var.container_registry_name
  resource_group_name = var.resourcegroup_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}