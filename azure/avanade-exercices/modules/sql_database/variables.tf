#TODO REVIEW THE VARIABLES VALUES
variable "resource_group_name" {
  description = "Nome do grupo de recursos."
  default = "production"
}

variable "location" {
  description = "Região do Azure."
  default = "eu-west"
}

variable "db_name" {
  description = "Name of the Database."
  default = "DotNetAppSqlDb_db"
}


#TODO CHANGE THE LOGIN AND PASSWORD TO SECRET
variable "administrator_login" {
  description = "MSQL Administrator Login"
  default = "4dm1n157r470r"
}

#TODO CHANGE THE LOGIN AND PASSWORD TO SECRET OR IMPLEMENT AN RANDOM PASSWORD
#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
variable "administrator_login_password" {
  description = "MSQL Administrator Login Password"
  default = "4-v3ry-53cr37-p455w0rd"
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