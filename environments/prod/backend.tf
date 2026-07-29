terraform {
  backend "azurerm" {
    resource_group_name  = "rg-summit-tfstate"
    storage_account_name = "stsummittfstatejr81"
    container_name       = "tfstate"
    key                  = "orders-prod.terraform.tfstate"
  }
}