resource "azurerm_network_security_group" "backend_nsg" {
  name                = "backend-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-ssh-ipv6"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    source_address_prefix      = "::/0"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-dns-tcp"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "53"
    destination_address_prefix = "0.0.0.0/0"
  }
  security_rule {
    name                       = "allow-dns-tcp-ipv6"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "53"
    destination_address_prefix = "::/0"
  }

  security_rule {
    name                       = "allow-dns-udp"
    priority                   = 140
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "53"
    destination_address_prefix = "0.0.0.0/0"
  }
  security_rule {
    name                       = "allow-dns-udp-ipv6"
    priority                   = 150
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "53"
    destination_address_prefix = "::/0"
  }

  security_rule {
    name                       = "allow-out-http-tcp"
    priority                   = 160
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "80"
    destination_address_prefix = "0.0.0.0/0"
  }
  security_rule {
    name                       = "allow-out-http-tcp-ipv6"
    priority                   = 170
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "80"
    destination_address_prefix = "::/0"
  }

  security_rule {
    name                       = "allow-out-http-udp"
    priority                   = 180
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "80"
    destination_address_prefix = "0.0.0.0/0"
  }
  security_rule {
    name                       = "allow-out-http-udp-ipv6"
    priority                   = 190
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "80"
    destination_address_prefix = "::/0"
  }

  security_rule {
    name                       = "allow-out-https-tcp"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "443"
    destination_address_prefix = "0.0.0.0/0"
  }
  security_rule {
    name                       = "allow-out-https-tcp-ipv6"
    priority                   = 210
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "443"
    destination_address_prefix = "::/0"
  }

  security_rule {
    name                       = "allow-out-https-udp"
    priority                   = 220
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "443"
    destination_address_prefix = "0.0.0.0/0"
  }
  security_rule {
    name                       = "allow-out-https-udp-ipv6"
    priority                   = 230
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "443"
    destination_address_prefix = "::/0"
  }

  security_rule {
    name                       = "allow-in-http-tcp"
    priority                   = 240
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    source_address_prefix      = "10.0.1.1/32"
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
    source_address_prefix      = "10.0.1.1/32"
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
    source_address_prefix      = "10.0.1.1/32"
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
    source_address_prefix      = "10.0.1.1/32"
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
    destination_address_prefix = "10.0.1.3/32"
  }
}

resource "azurerm_network_interface" "backend_network_interface" {
  name                = "backend_network_interface"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
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
  admin_username = var.admin_username

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

