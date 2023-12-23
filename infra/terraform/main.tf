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

resource "azurerm_network_interface" "network_interface" {
  name                = "main_network_interface"
  location            = azurerm_resource_group.crypto_bank.location
  resource_group_name = azurerm_resource_group.crypto_bank.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

module "api_server_1" {
  source = "./modules/api-server"

  name = "api1"
  resource_group_name = azurerm_resource_group.crypto_bank.name
  location = "West Europe"
  size = "Standard_F2"
  admin_username = "adminuser"
  network_interface_ids = [azurerm_network_interface.network_interface.id]
}