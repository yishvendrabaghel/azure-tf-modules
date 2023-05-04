resource "azurerm_redis_cache" "example" {
  name                = var.cache_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.cache_family
  sku_name            = var.sku_name
}
 #####firewall rule #############

 resource "azurerm_redis_firewall_rule" "example" {
  name                = var.firewall_name
  resource_group_name = var.resource_group_name
  redis_cache_name    = azurerm_redis_cache.example.name
  start_ip            = "0.0.0.0"
  end_ip              = "255.255.255.255"
}


output "redis_connection_string" {
  value = azurerm_redis_cache.example.primary_connection_string
}