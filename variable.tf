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

variable "boot_storage_account_name" {
  description = "The name of the storage account for boot diagnostics."
  type        = string
  default     = "iasegunbootstorage1"
}

