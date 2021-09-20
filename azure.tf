resource "azurerm_virtual_machine" "main" {
  name                  = "my-vm-${count.index}"
  count = var.hello_tf_instance_count
  location              = var.location
  resource_group_name   = var.rg
  network_interface_ids = [azurerm_network_interface.example.*.id[count.index]]
  vm_size               = "Standard_DS1_v2"

  os_profile {
    computer_name  = "kabu-comp"
    admin_username = "vmadmin"
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "my-osdisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "my-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name   = var.rg
}

resource "azurerm_subnet" "example" {
  name                 = "my-subnet"
  resource_group_name   = var.rg
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "example" {
  name                = "my-nw-interface-${count.index}"
  count = var.hello_tf_instance_count
  location            = var.location
  resource_group_name   = var.rg

  ip_configuration {
    name                          = "my-ip-config"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "payground"
  }
}