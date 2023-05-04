resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  timeouts {
    create = "30m"
    delete = "15m"
    read   = "5m"
    update = "20m"
  }
  
}
resource "azurerm_storage_container" "container" {
  name                  = var.storage_container_name
  storage_account_name  = var.storage_account_name
  container_access_type = var.container_access_type
}

resource "azurerm_storage_blob" "storage_container1" {
  name                   = var.blb_strg_name
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = var.blb_strg_type
  source = var.blob_src
}
output "blob-str-name-for-cluster" {
  value = azurerm_storage_account.storage.name
}