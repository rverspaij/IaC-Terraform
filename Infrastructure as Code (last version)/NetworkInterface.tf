resource "azurerm_network_interface" "app_interface1" {
  name                = "${var.projName}-app-interface1"
  location            = var.default-location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.LAN.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_subnet.LAN
  ]
}

resource "azurerm_network_interface" "app_interface2" {
  name                = "${var.projName}-app-interface2"
  location            = var.default-location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.LAN.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_virtual_network.vnet,
    azurerm_subnet.LAN
  ]
}