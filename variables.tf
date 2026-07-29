variable "vm_admin_password" {
  description = "Admin password for the Orders dev VM. Supplied at run time, never stored in the repo."
  type        = string
  sensitive   = true
}

variable "allowed_ssh_source" {
  description = "The single public IP address allowed to reach the VM on port 22, in CIDR form."
  type        = string
}

resource "azurerm_storage_account" "orders" {
  # CHANGE THIS: replace <suffix> with your 4-character student suffix.
  # Storage account names are globally unique across all of Azure,
  # 3-24 characters, lowercase letters and digits only. No hyphens.
  name                     = "stsummitordersdevjr81"
  resource_group_name      = azurerm_resource_group.orders.name
  location                 = azurerm_resource_group.orders.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = azurerm_resource_group.orders.tags
}

resource "azurerm_storage_container" "data" {
  name                  = "orders-data"
  storage_account_id    = azurerm_storage_account.orders.id
  container_access_type = "private"
}

