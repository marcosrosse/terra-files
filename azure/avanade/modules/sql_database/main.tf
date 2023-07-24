#TODO CHANGE SKU TO FREE TIER

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_string" "login" {
  length           = 16
  special          = false
  lower            = true
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sqlserver"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = random_string.login.result
  administrator_login_password = random_password.password.result
}

resource "azurerm_mssql_database" "sqlserver" {
  name           = var.db_name
  server_id      = azurerm_mssql_server.sqlserver.id
  collation      = var.azurerm_mssql_database_collation
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = var.azurerm_mssql_database_sku
  zone_redundant = false
  long_term_retention_policy {
    yearly_retention = var.yearly_retention_value
  }

  tags = {
    environment = "Production"
  }
}