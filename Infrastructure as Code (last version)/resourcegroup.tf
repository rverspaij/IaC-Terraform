resource "azurerm_resource_group" "rg" {
  name     = "${var.projName}-rg"
  location = var.default-location
  tags     = var.default-tags
}