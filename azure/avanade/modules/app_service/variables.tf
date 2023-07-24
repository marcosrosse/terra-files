#TODO REVIEW THE VARIABLES VALUES
variable "resource_group_name" {
  description = "Resource group name."
  default = "production"
}

variable "location" {
  description = "Azure region."
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
  default = 1
}

variable "front_door_sku_name" {
  type    = string
  default = "Standard_AzureFrontDoor"
  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.front_door_sku_name)
    error_message = "The SKU value must be Standard_AzureFrontDoor or Premium_AzureFrontDoor."
  }
}