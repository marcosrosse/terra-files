module "log_analytics" {
  source  = "Azure/log-analytics/azurerm"
  version = "1.0.1"

  resource_group_name = var.resource_group_name
  location            = var.location
  workspace_name      = "MyLogAnalyticsWorkspace"
  sku                 = "PerGB2018"
  retention_in_days   = 365 # Substitua pelo período de retenção desejado
}
