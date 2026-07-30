moved {
  from = azurerm_storage_container.orders_data
  to   = azurerm_storage_container.this["orders-data"]
}