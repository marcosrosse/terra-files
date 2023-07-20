#TODO REVIEW THE VARIABLES VALUES
variable "resource_group_name" {
  description = "Nome do grupo de recursos."
  default = "production"
}

variable "location" {
  description = "Região do Azure."
  default = "eu-west"
}

variable "appservice_name" {
  description = "App Service Plan Name"
  default = "avanade_app_svc"
}

variable "appservice_sku_name" {
  description = "SKU Name"
  default = "P1v2"
}

variable "appservice_os_type" {
  description = "OS Type"
  default = "Linux"
}

variable "appservice_worker_count" {
  description = "Quantity of workers"
  default = 2
}

variable "detailed_error_messages" {
  default = true
}

variable "failed_request_tracing" {
  default = true
}