#TODO CHANGE SKU TO FREE TIER
resource "azurerm_resource_group" "service_plan" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "service_plan" {
  name                = var.appservice_name
  resource_group_name = azurerm_resource_group.service_plan.name
  location            = azurerm_resource_group.service_plan.location
  os_type             = var.appservice_os_type
  sku_name            = var.appservice_sku_name
  worker_count        = var.appservice_worker_count
}

resource "azurerm_linux_web_app" "app" {
  name                = var.appservice_name
  resource_group_name = azurerm_resource_group.service_plan.name
  location            = azurerm_service_plan.service_plan.location
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {
    ftps_state          = "Disabled"
    minimum_tls_version = "1.2"
  }
}
