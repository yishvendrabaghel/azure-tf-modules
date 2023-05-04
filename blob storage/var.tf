################azurerm_storage_account ##############
variable "storage_account_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "account_tier" {}
variable "account_replication_type" {}

  ##################azurerm_storage_container##################

variable "storage_container_name" {}
variable "container_access_type" {}

  #################blob_storage############

variable "blb_strg_name" {}
variable "blb_strg_type" {}
variable "blob_src" {}
