resource "azurerm_virtual_network" "vnet" {
  name                = "${var.projName}-vnet"
  location            = var.default-location
  tags                = var.default-tags
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "LAN" {
  name                 = "${var.projName}-LAN"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  #delegation {
  # name = "fs"

  #service_delegation {
  # name = "Microsoft.DBforMySQL/flexibleServers"
  #}
  #}
}

resource "azurerm_subnet" "DMZ" {
  name                 = "${var.projName}-DMZ"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_private_dns_zone" "pdns" {
  name                = "subdomain.${var.projName}.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "pdnslink" {
  name                  = "${var.projName}-pdnslink"
  private_dns_zone_name = azurerm_private_dns_zone.pdns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.rg.name
}