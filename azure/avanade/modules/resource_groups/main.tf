resource "azurerm_resource_group" "production" {
  name     = var.resource_group_name
  location = var.location
}