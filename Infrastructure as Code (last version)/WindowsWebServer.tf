resource "azurerm_windows_virtual_machine" "Web_vm1" {
  name                = "${var.projName}-Web-vm1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.default-location
  size                = "Standard_D2s_v3"
  admin_username      = "GebruikerRaoul"
  admin_password      = "Admin01!"
  network_interface_ids = [
    azurerm_network_interface.app_interface1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.app_interface1
  ]
}

resource "azurerm_virtual_machine_extension" "vm_extension1" {
  name                 = "${var.projName}-vm-extension1"
  virtual_machine_id   = azurerm_windows_virtual_machine.Web_vm1.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  depends_on = [
    azurerm_storage_blob.IIS_config_video
  ]

  settings = <<SETTINGS
    {
        "fileUris": ["https://${azurerm_storage_account.appstore.name}.blob.core.windows.net/data/IIS_Config_video.ps1"],
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file IIS_Config_video.ps1"     
    }
SETTINGS
}

resource "azurerm_windows_virtual_machine" "Web_vm2" {
  name                = "${var.projName}-web-vm2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.default-location
  size                = "Standard_D2s_v3"
  admin_username      = "GebruikerRaoul"
  admin_password      = "Admin01!"
  network_interface_ids = [
    azurerm_network_interface.app_interface2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.app_interface2
  ]
}

resource "azurerm_virtual_machine_extension" "vm_extension2" {
  name                 = "${var.projName}-vm-extension2"
  virtual_machine_id   = azurerm_windows_virtual_machine.Web_vm2.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  depends_on = [
    azurerm_storage_blob.IIS_config_image
  ]
  settings = <<SETTINGS
    {
        "fileUris": ["https://${azurerm_storage_account.appstore.name}.blob.core.windows.net/data/IIS_Config_image.ps1"],
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file IIS_Config_image.ps1"     
    }
SETTINGS
}