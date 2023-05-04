resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm-name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [var.ni]
  vm_size               = var.vm_size

  
  storage_os_disk {
    name              = var.sod-name
    caching           = var.sod-caching
    create_option     = var.sod-create-option
    managed_disk_type = var.sod-man-dis-typ
  }
  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data =  file("~/.ssh/id_rsa.pub")
    }
  }
  tags = var.additional_tags
}