resource "azurerm_network_security_group" "backend_nsg" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-in-http-tcp"
    priority                   = 240
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    source_address_prefixes    = var.clients_address_prefixes
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-in-http-udp"
    priority                   = 250
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "80"
    source_address_prefixes    = var.clients_address_prefixes
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-in-https-tcp"
    priority                   = 260
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    source_address_prefixes    = var.clients_address_prefixes
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-in-https-udp"
    priority                   = 270
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "443"
    source_address_prefixes    = var.clients_address_prefixes
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "allow-db"
    priority                   = 280
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "5432"
    destination_address_prefix = var.database_address_prefix
  }
}

resource "azurerm_network_interface" "backend_network_interface" {
  name                = "${var.name}_network_interface"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
  }
}

resource "azurerm_network_interface_security_group_association" "backend_nsg_association" {
  network_interface_id      = azurerm_network_interface.backend_network_interface.id
  network_security_group_id = azurerm_network_security_group.backend_nsg.id
}


resource "azurerm_linux_virtual_machine" "backend_server" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username

  network_interface_ids = [azurerm_network_interface.backend_network_interface.id]

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

