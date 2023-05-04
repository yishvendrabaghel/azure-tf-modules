resource "azurerm_lb" "lb_balancer" {
  name                = "lb-balancer"
  location            = var.location
  resource_group_name = var.resource_group_name
  frontend_ip_configuration {
    name                 = var.front-end-ip-name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  depends_on=[
    azurerm_public_ip.public_ip
  ]
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"

  tags = var.additional_tags
}
resource "azurerm_lb_backend_address_pool" "scalesetpool" {
  loadbalancer_id = azurerm_lb.lb_balancer.id
  name            = "scalesetpool"
  depends_on=[
    azurerm_lb.lb_balancer
  ]
}
// Here we are defining the Health Probe
resource "azurerm_lb_probe" "ProbeA" {
  #resource_group_name = azurerm_resource_group.at.name
  loadbalancer_id     = azurerm_lb.lb_balancer.id
  name                = var.HP_name
  port                = var.port
  protocol            =  "Tcp"
  depends_on=[
    azurerm_lb.lb_balancer
  ]
}
// Here we are defining the Load Balancing Rule
resource "azurerm_lb_rule" "RuleA" {
  loadbalancer_id                = azurerm_lb.lb_balancer.id
  name                           = "RuleA"
  protocol                       = "Tcp"
  frontend_port                  = var.port
  backend_port                   = var.port
  frontend_ip_configuration_name = var.front-end-ip-name
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.scalesetpool.id ]
}
locals {
 first_public_key = file("/home/yishvendra.baghel/.ssh/id_rsa.pub")
 }