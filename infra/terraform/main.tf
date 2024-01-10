module "shared_firewall"{
  source = "./modules/shared-firewall"

  resource_group_name = azurerm_resource_group.crypto_bank.name
  location = azurerm_resource_group.crypto_bank.location
}

resource "azurerm_resource_group" "crypto_bank" {
  name     = "crypto-bank-resources"
  location = "East Asia"
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
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = module.shared_firewall.id
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

  name = "backend-server-1"
  resource_group_name = azurerm_resource_group.crypto_bank.name
  location = azurerm_resource_group.crypto_bank.location

  size = "Standard_F2"
  admin_username = "adminuser"

  subnet_id = azurerm_subnet.subnet.id
  private_ip_address = "10.0.1.254"

  clients_address_prefixes = ["10.0.1.252/32"]

  public_key = "${local_file.public_key.content}"
}

module "database_server_1" {
  source = "./modules/database-server"

  name = "pg-database-server-1"
  port = "5432"
  resource_group_name = azurerm_resource_group.crypto_bank.name
  location = azurerm_resource_group.crypto_bank.location

  size = "Standard_F1"
  admin_username = "adminuser"

  subnet_id = azurerm_subnet.subnet.id
  private_ip_address = "10.0.1.253"
  
  servers_address_prefixes = ["10.0.1.254/32"]

  public_key = "${local_file.public_key.content}"
}

module "frontend_server_1" {
  source = "./modules/frontend-server"

  name = "frontend-server-1"
  resource_group_name = azurerm_resource_group.crypto_bank.name
  location = azurerm_resource_group.crypto_bank.location

  size = "Standard_F1"
  admin_username = "adminuser"

  subnet_id = azurerm_subnet.subnet.id
  private_ip_address = "10.0.1.252"

  public_key = "${local_file.public_key.content}"
}