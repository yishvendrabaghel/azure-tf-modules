resource "azurerm_mysql_server" "sql" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  ssl_enforcement_enabled      = true
  sku_name   = var.sku_name
  storage_mb = var.storage
  version    = "5.7"
}

resource "azurerm_mysql_database" "main" {
  name                = var.DB_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.sql.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}



