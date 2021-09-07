terraform {}

provider "azurerm" {
    features {}
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network-se-kabu"
  resource_group_name = "se-kabu"
  location            = "Japan East"
  address_space       = ["10.0.0.0/16"]
}