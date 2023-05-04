variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "SKU" {}
variable "instances" {
  type = number
}
variable "username" {}
variable "path-to-ssh-file" {}
  ########### source image ref ##########
variable "publisher" {}
variable "offer"{}
variable "SIR_sku" {}
variable "str_acc_type" {}
variable "caching" {}
variable "subnet_ID" {}