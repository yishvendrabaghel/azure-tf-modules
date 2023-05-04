variable "name"{}
variable "resource_group_name"{}
variable "location" {}
variable "admin_username" {}
variable "admin_password" {}
variable "sku_name" {}
variable "storage" {
  type = number
}
  #######3 DATABASE ###########

variable "DB_name" {}
variable "additional_tags" {
  
}