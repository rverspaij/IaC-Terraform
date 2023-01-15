resource "azurerm_storage_account" "appstore" {
  name                     = "appstore99887722"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.default-location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account_network_rules" "rules" {
  storage_account_id = azurerm_storage_account.appstore.id
  default_action     = "Allow"
  bypass             = ["Metrics", "Logging", "AzureServices"]
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.appstore.name
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.appstore
  ]
}

resource "azurerm_storage_blob" "IIS_config_test1" {
  name                   = "IIS_Config_test1.ps1"
  storage_account_name   = azurerm_storage_account.appstore.name
  storage_container_name = "data"
  type                   = "Block"
  source                 = "IIS_Config_test1.ps1"
  depends_on             = [azurerm_storage_container.data]
}

resource "azurerm_storage_blob" "IIS_config_test2" {
  name                   = "IIS_Config_test2.ps1"
  storage_account_name   = azurerm_storage_account.appstore.name
  storage_container_name = "data"
  type                   = "Block"
  source                 = "IIS_Config_test2.ps1"
  depends_on             = [azurerm_storage_container.data]
}