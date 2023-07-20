#TODO REVIEW THE VARIABLES VALUES
variable "resource_group_name" {
  description = "Nome do grupo de recursos."
  default = "production"
}

variable "location" {
  description = "Região do Azure."
  default = "eu-west"
}

variable "app_service_plan_sku_name" {
  type    = string
  default = "S1"
}

variable "app_service_plan_capacity" {
  type    = number
  default = 1
}

variable "app_service_plan_sku_tier_name" {
  type    = string
  default = "Standard"
}

variable "front_door_sku_name" {
  type    = string
  default = "Standard_AzureFrontDoor"
  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.front_door_sku_name)
    error_message = "The SKU value must be Standard_AzureFrontDoor or Premium_AzureFrontDoor."
  }
}