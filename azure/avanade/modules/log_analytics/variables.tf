#TODO REVIEW THE VARIABLES VALUES
variable "resource_group_name" {
  description = "Nome do grupo de recursos."
  default = "production"
}

variable "location" {
  description = "Região do Azure."
  default = "eu-west"
}

variable "log_analytics_name" {
  description = "Name of Log Analytics"
  default = "avanade-log-analytics"
}

variable "log_analytics_sku" {
  description = "SKU of Log Analytics"
  default = "PerGB2018"
}

variable "log_analytics_retention_days" {
  description = "Retention in days of Log Analytics"
  default = "365"
}