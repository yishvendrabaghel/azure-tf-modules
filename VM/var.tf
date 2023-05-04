variable "vm-name" {}
variable "location" {}
variable "resource_group_name" {}
variable "ni" {}
variable "vm_size" {}
#"""""""""""""""""""""storage os disk"""""""""""""""""""""
variable "sod-name" {}
variable "sod-caching" {}
variable "sod-create-option" {}
variable "sod-man-dis-typ" {}

#############storage_image_reference ###########

variable "publisher"{}
variable "offer"{}
variable "sku"{}
/* variable "version"{} */

############## "OS profile"  ##########

variable "computer_name" {}
variable "admin_username" {}
variable "admin_password" {}

variable "additional_tags" {}

/* variable "ssh_key_path" {
  
} */