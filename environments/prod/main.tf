terraform {
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
  name     = "rg-summit-orders-prod"
  location = "eastus"

  tags = {
    environment = "prod"
    solution    = "orders"
    owner       = "ops-team"
    managed_by  = "terraform"
  }
}