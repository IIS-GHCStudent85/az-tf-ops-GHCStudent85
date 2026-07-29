resource "azurerm_linux_virtual_machine" "app" {
  name                = "vm-summit-orders-dev"
  resource_group_name = azurerm_resource_group.orders.name
  location            = azurerm_resource_group.orders.location
  size                = "Standard_F1als_v7"

  admin_username                  = "azureuser"
  admin_password                  = var.vm_admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.app.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  tags = azurerm_resource_group.orders.tags
}

resource "azurerm_public_ip" "app" {
  name                = "pip-summit-orders-dev"
  resource_group_name = azurerm_resource_group.orders.name
  location            = azurerm_resource_group.orders.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = azurerm_resource_group.orders.tags
}