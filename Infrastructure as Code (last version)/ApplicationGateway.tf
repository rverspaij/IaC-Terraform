resource "azurerm_application_gateway" "app_gateway" {
  name                = "${var.projName}-app-gateway"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.default-location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "${var.projName}-gateway-ip-config"
    subnet_id = azurerm_subnet.DMZ.id
  }

  frontend_port {
    name = "${var.projName}-front-end-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${var.projName}-front-end-ip-config"
    public_ip_address_id = azurerm_public_ip.gateway_ip.id
  }

  backend_address_pool {
    name = "videopool"
    ip_addresses = [
    "${azurerm_network_interface.app_interface1.private_ip_address}"]
  }

  backend_address_pool {
    name = "imagepool"
    ip_addresses = [
    "${azurerm_network_interface.app_interface2.private_ip_address}"]
  }

  backend_http_settings {
    name                  = "${var.projName}-HTTPSetting"
    cookie_based_affinity = "Disabled"
    path                  = ""
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${var.projName}-gateway-listener"
    frontend_ip_configuration_name = "${var.projName}-front-end-ip-config"
    frontend_port_name             = "${var.projName}-front-end-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name               = "${var.projName}-RoutingRuleA"
    rule_type          = "PathBasedRouting"
    url_path_map_name  = "${var.projName}-RoutingPath"
    http_listener_name = "${var.projName}-gateway-listener"
  }

  url_path_map {
    name                               = "${var.projName}-RoutingPath"
    default_backend_address_pool_name  = "videopool"
    default_backend_http_settings_name = "${var.projName}-HTTPSetting"

    path_rule {
      name                       = "VideoRoutingRule"
      backend_address_pool_name  = "videopool"
      backend_http_settings_name = "${var.projName}-HTTPSetting"
      paths = [
        "/videos/*",
      ]
    }

    path_rule {
      name                       = "ImageRoutingRule"
      backend_address_pool_name  = "imagepool"
      backend_http_settings_name = "${var.projName}-HTTPSetting"
      paths = [
        "/images/*",
      ]
    }
  }
}