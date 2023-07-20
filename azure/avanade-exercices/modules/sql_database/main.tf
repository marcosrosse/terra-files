#TODO CHANGE SKU TO FREE TIER
#TODO REMOVE PROVIDER
resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sqlserver"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "sqlserver" {
  name           = var.db_name
  server_id      = azurerm_mssql_server.sqlserver.id
  collation      = var.azurerm_mssql_database_collation
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = var.azurerm_mssql_database_sku
  zone_redundant = true
  long_term_retention_policy {
    yearly_retention = var.yearly_retention_value
  }

  tags = {
    environment = "Production"
  }
}