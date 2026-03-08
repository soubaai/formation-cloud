provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "rg-test"
  location = "France Central"
}