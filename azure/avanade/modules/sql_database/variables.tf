#TODO REVIEW THE VARIABLES VALUES
variable "resource_group_name" {
  description = "Resource group name."
  default = "production"
}

variable "location" {
  description = "Azure Region."
  default = "westeurope"
}

variable "db_name" {
  description = "Name of the Database."
  default = "DotNetAppSqlDb_db"
}

variable "azurerm_mssql_database_collation" {
  description = "Collation of the database"
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "azurerm_mssql_database_sku" {
  description = "SKU of the database"
  default = "S0"

}

variable "yearly_retention_value" {
  description = "How many years of retention"
  default = "P3Y"
}