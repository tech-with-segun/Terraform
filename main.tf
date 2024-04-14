
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "segun-bossman-4334"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "segun-bossman-vnet"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "segun-bossman-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

resource "azurerm_public_ip" "pip" {
name = "segun-bossman-pip"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
allocation_method = "Dynamic"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "segun-bossman-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_network_interface" "nic" {
name = "segun-bossman-nic"
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name

ip_configuration {
name = "nic_configuration"
subnet_id = azurerm_subnet.subnet.id
private_ip_address_allocation = "Dynamic"
public_ip_address_id = azurerm_public_ip.pip.id
}
}

resource "azurerm_network_interface_security_group_association" "nic_connect" {
network_interface_id = azurerm_network_interface.nic.id
network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_storage_account" "boot_storage" {
name = var.storage_account_name
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
account_tier = "Standard"
account_replication_type = "LRS"
}

resource "azurerm_windows_virtual_machine" "main" {
name = "segun-bossmanvm"
admin_username = azurerm_key_vault_secret.vmusername.value
admin_password = azurerm_key_vault_secret.vmpassword.value
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
network_interface_ids = [azurerm_network_interface.nic.id]
size = var.vm_size

os_disk {
name = "myOsDisk"
caching = "ReadWrite"
storage_account_type = "Premium_LRS"
}

source_image_reference {
  publisher = "MicrosoftSQLServer"
  offer     = "SQL2019-WS2019"
  sku       = "Standard"
  version   = "latest"
}

boot_diagnostics {
storage_account_uri = azurerm_storage_account.boot_storage.primary_blob_endpoint
}
}

resource "azurerm_virtual_machine_extension" "web_server_install" {
name = "segun-bossman-iis-wsi"
virtual_machine_id = azurerm_windows_virtual_machine.main.id
publisher = "Microsoft.Compute"
type = "CustomScriptExtension"
type_handler_version = "1.8"
auto_upgrade_minor_version = true

settings = <<SETTINGS
{
"commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
}
SETTINGS
}

