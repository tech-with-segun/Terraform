provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

variable "client_id" {
  description = "The Client ID for Azure Service Principal"
}

variable "client_secret" {
  description = "The Client Secret for Azure Service Principal"
}

variable "tenant_id" {
  description = "The Tenant ID for Azure"
}

variable "subscription_id" {
  description = "The Subscription ID for Azure"
}
