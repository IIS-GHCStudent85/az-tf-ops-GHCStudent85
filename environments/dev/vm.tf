resource "azurerm_linux_virtual_machine" "app" {
  name                = "vm-${local.name_prefix}"
  resource_group_name = azurerm_resource_group.orders.name
  location            = azurerm_resource_group.orders.location
  size                = var.vm_size

  admin_username                  = var.vm_admin_username
  admin_password                  = data.azurerm_key_vault_secret.vm_admin_password.value
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

  tags = merge(local.tags, { role = "app-server" })
}

resource "azurerm_public_ip" "app" {
  name                = "pip-${local.name_prefix}"
  resource_group_name = azurerm_resource_group.orders.name
  location            = azurerm_resource_group.orders.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = local.tags
}