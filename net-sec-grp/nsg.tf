resource "azurerm_network_security_group" "subnet_nsg" {

  # name = "${azurerm_subnet.subnet[1]}-nsg"
  name = var.name
  location = var.location
  resource_group_name = var.resource_group_name
}

resource "random_integer" "random" {
  min = 1
  max = 100
}
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.address_space]
  
  tags = var.additional_tags
}


resource "azurerm_subnet" "subnet" {
  name                 = "${var.subnet_name}${1+count.index}"
  count                = var.public_subnet_count
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.${1+count.index}.0/24"]
  depends_on = [
    azurerm_virtual_network.vnet
  ]

}

output "sub-id-for-redis" {
  value = azurerm_subnet.subnet[1].id
}

resource "azurerm_network_interface" "ni" {
  name                = var.ni-name
  count = var.ni-count
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconf"
    subnet_id                     = azurerm_subnet.subnet[1].id
    private_ip_address_allocation = "Dynamic"

  }
  
}
output "ni-id-for-redis" {
  value = azurerm_network_interface.ni[1].id
}
output "host-for-redis" {
  value = azurerm_network_interface.ni[1].private_ip_address
}