variable "client_secret" {
}

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "ca279a1e-fa74-401b-b661-802eb88390b6"
  client_secret   = var.client_secret
  tenant_id       = "998f1477-c047-4c21-8f63-0ddeb50c1070"
  subscription_id = "b61f6c78-544f-48ad-9479-7728a6292de3"
}

variable "admin_username" {
  description = "The admin username for the Windows virtual machine"
  type        = string
  default     = "adminuser"
}

variable "location" {
  description = "The Azure region in which to create the resources."
  type        = string
  default     = "East US"
}

variable "subnet_address_prefix" {
  description = "The CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "vnet_address_space" {
  description = "The CIDR block for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_D2as_v4"
}

variable "kv_name" {
  description = "The name of the key vault."
  type        = string
  default     = "ia-kv-segun728"
}

variable "storage_account_name" {
  description = "The name of the storage account for boot diagnostics."
  type        = string
  default     = "iasegunbootstorage1"
}

