resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.k8s_clstr_name
  kubernetes_version  = var.k8s_version
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name                = var.node_pool_name
    node_count          = var.system_node_count
    vm_size             = var.vm_size
    type                = var.type
    #availability_zones  = [1, 2, 3]
    enable_auto_scaling = var.enable_auto_scaling
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" # CNI
  }
}