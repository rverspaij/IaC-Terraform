resource "azurerm_mysql_flexible_server" "mySQLDB" {
  name                   = "${var.projName}-mysql"
  count                  = local.database ? 1 : 0
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = var.username
  administrator_password = var.password
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.Sub-DB.id
  private_dns_zone_id    = azurerm_private_dns_zone.pdns.id
  sku_name               = "B_Standard_B1s"

  depends_on = [azurerm_private_dns_zone_virtual_network_link.pdnslink]
}