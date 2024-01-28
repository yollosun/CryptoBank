resource "azurerm_network_security_group" "shared_nsg" {
  name                = "shared-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "0.0.0.0/0"
    destination_port_range     = "22"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-ssh-ipv6"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "::/0"
    destination_port_range     = "22"
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
}


