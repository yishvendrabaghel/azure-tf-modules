###   AZ group  ###

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "at" {
  name     = "Azure-terraform11"
  location = "Central India"
  tags     = var.addtional_tags
}

variable "addtional_tags" {
  type = map(string)
  default = {
    "Name"         = "Rao sahab"
    "organization" = "kellton"
    "Approved_by"  = "owner"
  }
}

module "nsg_vnet" {
  source              = "./net-sec-grp"
  name                = "NSG_name1"
  location            = azurerm_resource_group.at.location
  resource_group_name = azurerm_resource_group.at.name
  vnet-name           = "vnet-network"
  address_space       = "10.1.0.0/16"
  additional_tags     = var.addtional_tags
  public_subnet_count = 5
  subnet_name         = "subnet-"
  ni-name             = "net_interface"
  ni-count            = 3
}

module "VMs" {
  source              = "./VM"
  vm-name             = "prac-VMs"
  location            = azurerm_resource_group.at.location
  resource_group_name = azurerm_resource_group.at.name
  ni                  = module.nsg_vnet.ni-id-for-redis
  vm_size             = "Standard_DS1_v2"

  ##################storage on disk############
  sod-name          = "myosdisk1"
  sod-caching       = "ReadWrite"
  sod-create-option = "FromImage"
  sod-man-dis-typ   = "Standard_LRS"

  #############storage_image_reference ###########
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "16.04-LTS"

  ############## "OS profile"  ##########
  computer_name  = "hostname"
  admin_username = "username"
  admin_password = "password@123"

  additional_tags = var.addtional_tags
}
module "blob_storage" {
  source = "./blob storage"

  ################storage_account ##############

  storage_account_name     = "tfstorage0135"
  location                 = azurerm_resource_group.at.location
  resource_group_name      = azurerm_resource_group.at.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  ##################storage_container##################

  storage_container_name = "stgcntdash1"
  container_access_type  = "private"

  #################blob_storage############

  blb_strg_name = "blb-strg"
  blb_strg_type = "Block"
  blob_src      = "/home/yishvendra.baghel/Downloads/image1.jpg"
}

module "k8s_cluster" {
  source              = "./k8s cluster"
  k8s_clstr_name      = "kubcus555"
  k8s_version         = "1.26.3"
  location            = azurerm_resource_group.at.location
  resource_group_name = azurerm_resource_group.at.name
  dns_prefix          = "foo"
  ########## node pool ############

  node_pool_name      = "system"
  system_node_count   = 2
  vm_size             = "Standard_DS2_v2"
  type                = "VirtualMachineScaleSets"
  enable_auto_scaling = false
}

module "container-registry" {
  location            = azurerm_resource_group.at.location
  resource_group_name = azurerm_resource_group.at.name



  source        = "./container registry"
  name          = "teststorage1234"
  sku           = "Standard"
  admin_enabled = true

}

module "SQL_server" {
  source              = "./SQL_server"
  name                = "serverchinu"
  location            = azurerm_resource_group.at.location
  resource_group_name = azurerm_resource_group.at.name

  admin_username = "chinu"
  admin_password = "password@123"
  sku_name       = "B_Gen5_2"
  storage        = "5120"

  #######3 DATABASE ###########
  DB_name         = "DB_chinu"
  additional_tags = var.addtional_tags
}

module "load_balancer" {
  source              = "./load balancer"
  name                = "chinu-lb"
  location            = azurerm_resource_group.at.location
  resource_group_name = azurerm_resource_group.at.name
  public_ip           = "chinu-pub-IP"

  front-end-ip-name = "front-end-ip"
  additional_tags   = var.addtional_tags

  ############### LB health probe ###########

  HP_name = "probeA"
  port    = 80
}

module "vmss" {
  source              = "./VMSS"
  name                = "chinu-VMSS"
  location            = azurerm_resource_group.at.location
  resource_group_name = azurerm_resource_group.at.name
  SKU                 = "Standard_DS1_v2"
  instances           = 1
  username            = "adminuser"
  path-to-ssh-file    = "/home/yishvendra.baghel/.ssh/id_rsa.pub"


  ########### source image ref ##########
  publisher    = "Canonical"
  offer        = "UbuntuServer"
  SIR_sku      = "16.04-LTS"
  str_acc_type = "Standard_LRS"
  caching      = "ReadWrite"
  subnet_ID    = module.nsg_vnet.subnet_ID
}

module "redis_cluster" {
  source = "./redis"
  cache_name = "chinu-redis"
  location            = azurerm_resource_group.at.location
  resource_group_name = azurerm_resource_group.at.name
  capacity = 1
  cache_family = "C"
  sku_name = "Basic"
 #####firewall rule #############
  firewall_name = "redis_firewall_rule"

}