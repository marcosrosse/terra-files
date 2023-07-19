# module "sql_server" {
#   source  = "Azure/sql-server/azurerm"
#   version = "4.6.0"

#   resource_group_name = var.resource_group_name
#   location            = var.location
#   version             = "12.0"
#   name                = "MySqlServer"
#   administrator_login          = "sqladmin" # Substitua pelo nome de login desejado
#   administrator_login_password = "Password123!" # Substitua pela senha desejada
# }

# module "sql_database" {
#   source  = "Azure/sql-db/azurerm"
#   version = "3.2.0"

#   resource_group_name = var.resource_group_name
#   location            = var.location
#   server_name         = module.sql_server.name
#   name                = "DotNetAppSqlDb_db"
#   edition             = "Standard"
#   collation           = "SQL_Latin1_General_CP1_CI_AS"
#   backup {
#     retention_days = 1095 # Retenção de backup por 3 anos (365 * 3)
#   }
# }

resource "azurerm_mssql_server" "example" {
  name                         = "mssqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = "00000000-0000-0000-0000-000000000000"
  }

  tags = {
    environment = "production"
  }
}