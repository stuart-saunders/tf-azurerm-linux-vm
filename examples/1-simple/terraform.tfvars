resource_group = {
  name     = "rg-vm-module-test"
  location = "uksouth"
}

vnet = {
  name          = "vnet1"
  address_space = ["10.0.0.0/16"]

  subnet = {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }
}

vm = {
  name = "vm1"
  size = "Standard_B2s"

  admin_username = "adminuser"
  admin_password = "p@ssw0rd1234!!"

  disable_password_authentication = false

  os_disk = {
    name                 = "vm1-os"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19_04-gen2"
    version   = "latest"
  }

  network_interface = {
    name = "internal-nic"
    ip_configuration = {
      name                          = "internal"
      private_ip_address_allocation = "Dynamic"
    }
  }
}