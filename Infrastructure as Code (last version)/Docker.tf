resource "azurerm_service_plan" "sPlan" {
  name                = "${var.projName}-sPlan"
  count               = local.docker ? 1 : 0
  location            = var.default-location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "P1v2"
}


resource "azurerm_linux_web_app" "appService" {
  name                = "${var.projName}-App"
  count               = local.docker ? 1 : 0
  location            = var.default-location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.sPlan[count.index].id

  https_only = true

  site_config {
    always_on = true

    application_stack {
      docker_image     = "rverspaij/test"
      docker_image_tag = "latest"
      dotnet_version   = "6.0"
    }
  }
}

resource "azurerm_container_registry" "cRegistry" {
  name                = "${var.projName}cRegistry"
  count               = local.docker ? 1 : 0
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.default-location
  sku                 = "Basic"
}

# URL from web app is: http://raoul-App.azurewebsites.net