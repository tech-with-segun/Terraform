terraform {
  backend "azurerm" {
    resource_group_name  = "segunterrastorage-rg"
    storage_account_name = "segunterrastorage23"
    container_name       = "terracontainernowsegun"
    key                  = "terraform.tfstate"
  }
}
