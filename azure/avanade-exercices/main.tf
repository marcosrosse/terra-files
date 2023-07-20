#TODO FIX ERROR WITH THE VARIABLES OF THE MODULES

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
}
provider "azurerm" {
  features {}
}

module "app_service" {
  source  = "./modules/app_service"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "sql_database" {
  source  = "./modules/sql_database"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "front_door" {
  source  = "./modules/front_door"
  resource_group_name = var.resource_group_name
  location            = var.location
  # app_service_endpoints = [module.app_service.default_site_hostname]
}

module "log_analytics" {
  source  = "./modules/log_analytics"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  source  = "./modules/virtual_network"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# module "web_application_firewall" {
#   source  = "./modules/web_application_firewall"
#   resource_group_name = var.resource_group_name
#   location            = var.location
# }

module "key_vault" {
  source  = "./modules/key_vault"
  resource_group_name = var.resource_group_name
  location            = var.location
}
