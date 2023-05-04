variable "location" {
  description = "The location for the deployment"
}
variable "name"{}
variable "resource_group_name" {}
variable "vnet-name" {}  
variable "address_space"{}
variable "additional_tags" {}
variable "public_subnet_count" {}
variable "subnet_name" {}
variable "ni-name"{}
variable "ni-count" {
  type = number
}