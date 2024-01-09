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

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "public_key" {
  content  = tls_private_key.private_key.public_key_openssh
  filename = "azure_ssh_key.pub"
}

module "backend_server_1" {
  source = "./modules/backend-server"

  name = "backend_server_1"
  resource_group_name = azurerm_resource_group.crypto_bank.name
  location = azurerm_resource_group.crypto_bank.location
  size = "Standard_F2"
  admin_username = "adminuser"

  subnet_id = azurerm_subnet.subnet.id

  public_key = "${local_file.public_key.content}"
}