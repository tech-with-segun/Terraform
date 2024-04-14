terraform {
  backend "azurerm" {
    resource_group_name  = "segs-boss-tfstorage-rg"
    storage_account_name = "seguntfstorage93"
    container_name       = "tfcontainerbosssegun"
    key                  = "terraform.tfstate"
  }
}
