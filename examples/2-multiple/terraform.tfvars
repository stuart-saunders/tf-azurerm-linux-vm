resource_group = {
  name     = "rg-vm-module-test"
  location = "uksouth"
}

vnets = [
  {
    name          = "vnet1"
    address_space = ["10.0.0.0/16"]

    subnets = [
      {
        name             = "subnet1"
        address_prefixes = ["10.0.1.0/24"]

        vms = [
          {
            name = "vn1-sn1-vm1"
            size = "Standard_B2s"

            admin_username = "adminuser"

            os_disk = {
              caching              = "ReadWrite"
              storage_account_type = "Standard_LRS"
            }

            source_image_reference = {
              publisher = "Canonical"
              offer     = "UbuntuServer"
              sku       = "19_04-gen2"
              version   = "latest"
            }
          }
        ]
      }
    ]
  },
  {
    name          = "vnet2"
    address_space = ["10.1.0.0/16"]

    subnets = [
      {
        name             = "subnet1"
        address_prefixes = ["10.1.1.0/24"]

        vms = [
          {
            name = "vn2-sn1-vm1"
            size = "Standard_B2s"

            admin_username = "adminuser"

            os_disk = {
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
              name = "vn2-sn1-vm1-nic"
              ip_configuration = {
                name                          = "vm1-config"
                private_ip_address_allocation = "Dynamic"
                primary                       = true
              }
            }
          },
          {
            name = "vn2-sn1-vm2"
            size = "Standard_B2s"

            admin_username = "adminuser"

            os_disk = {
              caching              = "ReadWrite"
              storage_account_type = "Standard_LRS"
            }

            source_image_reference = {
              publisher = "Canonical"
              offer     = "UbuntuServer"
              sku       = "19_04-gen2"
              version   = "latest"
            }
          }
        ]
      },
      {
        name             = "subnet2"
        address_prefixes = ["10.1.2.0/24"]

        vms = [
          {
            name = "vn2-sn2-vm1"
            size = "Standard_B2s"

            admin_username = "adminuser"

            enable_ip_forwarding = true

            os_disk = {
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
              ip_configuration = {
                name = "config"
              }
            }
          },
          {
            name = "vn2-sn2-vm2"
            size = "Standard_B2s"

            admin_username = "adminuser"

            os_disk = {
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
              ip_configuration = {
                name                          = "ip-config"
                private_ip_address_allocation = "Dynamic"
              }
            }
          }
        ]
      }
    ]
  }
]