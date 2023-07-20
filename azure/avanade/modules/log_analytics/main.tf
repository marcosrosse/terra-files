#TODO CHANGE SKU TO FREE TIER
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = azurerm_resource_group.log_analytics.name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_analytics_retention_days
}