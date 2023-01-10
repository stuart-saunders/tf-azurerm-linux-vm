resource "azurerm_resource_group" "this" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet.name
  address_space       = var.vnet.address_space
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
  name                 = var.vnet.subnet.name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.vnet.subnet.address_prefixes
}

resource "azurerm_network_security_group" "this" {
  name                = "remote-connection-nsg"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_public_ip" "this" {
  name                = "${var.vm.name}-ip"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
}

module "vm" {
  source = "../../"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  name = var.vm.name
  size = var.vm.size

  admin_username = var.vm.admin_username
  admin_password = var.vm.admin_password

  disable_password_authentication = var.vm.disable_password_authentication

  os_disk                = var.vm.os_disk
  source_image_reference = var.vm.source_image_reference

  network_interface = {
    name = var.vm.network_interface.name
    ip_configuration = {
      name                          = var.vm.network_interface.ip_configuration.name
      private_ip_address_allocation = var.vm.network_interface.ip_configuration.private_ip_address_allocation
      public_ip_address_id          = azurerm_public_ip.this.id
      subnet_id                     = azurerm_subnet.this.id
    }
  }
}