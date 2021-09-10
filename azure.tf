resource "azurerm_virtual_network" "example" {
  name                = "example-network-se-kabu"
  resource_group_name = "se-kabu"
  location            = "Japan Easty"
  address_space       = ["10.10.0.0/16"]
}