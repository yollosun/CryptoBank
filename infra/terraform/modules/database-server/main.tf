resource "azurerm_network_security_group" "database_nsg" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "allow-ssh"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_port_range     = "22"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-servers-ips"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefixes    = var.clients_address_prefixes
    destination_port_range     = var.port
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "db_public_ip" {
  name                = "db_public_ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "database_network_interface" {
  name                = "${var.name}_network_interface"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address

    public_ip_address_id = azurerm_public_ip.db_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "database_nsg_association" {
  network_interface_id      = azurerm_network_interface.database_network_interface.id
  network_security_group_id = azurerm_network_security_group.database_nsg.id
}


resource "azurerm_linux_virtual_machine" "database_server" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username

  network_interface_ids = [azurerm_network_interface.database_network_interface.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

