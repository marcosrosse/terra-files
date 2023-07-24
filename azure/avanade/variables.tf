#TODO REVIEW THE VARIABLES VALUES
variable "resource_group_name" {
  description = "Resource group name."
  default = "production"
}

variable "location" {
  description = "Azure Region."
  default = "westeurope"
}

variable "appservice_name" {
  description = "App Service Plan Name"
  default = "avanade-app"
}

variable "appservice_sku_name" {
  description = "SKU Name"
  default = "F1"
}

variable "appservice_os_type" {
  description = "OS Type"
  default = "Linux"
}

variable "appservice_worker_count" {
  description = "Quantity of workers"
  default = 2
}

variable "front_door_sku_name" {
  type    = string
  default = "Standard_AzureFrontDoor"
  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.front_door_sku_name)
    error_message = "The SKU value must be Standard_AzureFrontDoor or Premium_AzureFrontDoor."
  }
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