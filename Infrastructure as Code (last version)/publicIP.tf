resource "azurerm_public_ip" "gateway_ip" {
  name                = "${var.projName}-gateway-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.default-location
  allocation_method   = "Dynamic"
}