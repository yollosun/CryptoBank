


resource "azurerm_resource_group" "crypto_bank" {
  name     = "crypto-bank-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "network" {
  name                = "main_network"
  resource_group_name = azurerm_resource_group.crypto_bank.name
  location            = azurerm_resource_group.crypto_bank.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.crypto_bank.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.0.0/16"]
}