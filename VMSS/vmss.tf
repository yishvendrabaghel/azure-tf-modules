resource "azurerm_linux_virtual_machine_scale_set" "replica" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.SKU
  instances           = var.instances
  admin_username      = var.username

  admin_ssh_key {
    username   = var.username
    public_key = file("${var.path-to-ssh-file}")
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.SIR_sku
    version   = "latest"
  }

  os_disk {
    storage_account_type = var.str_acc_type
    caching              = var.caching
  }

  network_interface {
    name    = "vm2"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_ID

    }
  }
}