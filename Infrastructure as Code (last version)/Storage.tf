resource "azurerm_storage_account" "appstore" {
  name                            = "appstore912094"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.default-location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = true
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = "appstore912094"
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.appstore
  ]
}

resource "azurerm_storage_blob" "IIS_config_video" {
  name                   = "IIS_Config_video.ps1"
  storage_account_name   = "appstore912094"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "IIS_Config_video.ps1"
  depends_on             = [azurerm_storage_container.data]
}

resource "azurerm_storage_blob" "IIS_config_image" {
  name                   = "IIS_Config_image.ps1"
  storage_account_name   = "appstore912094"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "IIS_Config_image.ps1"
  depends_on             = [azurerm_storage_container.data]
}