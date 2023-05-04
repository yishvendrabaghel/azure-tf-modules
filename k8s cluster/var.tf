variable "k8s_clstr_name" {}
variable "k8s_version" {}
variable "location" {}
variable "resource_group_name" {}
variable "dns_prefix" {}
  ########## node pool ############
  
variable "node_pool_name" {}
variable "system_node_count" {
    type        = number
}
variable "vm_size" {}
variable "type" {}
variable "enable_auto_scaling" {}
