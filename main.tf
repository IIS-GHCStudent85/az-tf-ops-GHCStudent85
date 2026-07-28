terraform {
  # import blocks, moved blocks, and config generation all need a recent CLI.
  required_version = ">= 1.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "orders" {
  name     = "rg-summit-orders-dev"
  location = "eastus"

  tags = {
    environment = "dev"
    solution    = "orders"
    owner       = "ops-team"
    managed_by  = "terraform"
  }
}

resource "azurerm_virtual_network" "orders" {
  name                = "vnet-summit-orders-dev"
  resource_group_name = azurerm_resource_group.orders.name
  location            = azurerm_resource_group.orders.location
  address_space       = ["10.10.0.0/16"]

  tags = azurerm_resource_group.orders.tags
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.orders.name
  virtual_network_name = azurerm_virtual_network.orders.name
  address_prefixes     = ["10.10.1.0/24"]
}

