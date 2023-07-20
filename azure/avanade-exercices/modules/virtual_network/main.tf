#TODO CHANGE SKU TO FREE TIER
#TODO REVISIT AGAIN AND DO SOME CHANGES
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "vpc" {
  name                = var.vpc_name
  location            = azurerm_network_security_group.nsg.location
  resource_group_name = azurerm_network_security_group.nsg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.nsg.id
  }
  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  tags = {
    environment = "Production"
  }
}