provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

terraform {
  cloud {
    organization = "Dune-Global"

    workspaces {
      name = "green-supermarket"
    }
  }
}

resource "azurerm_resource_group" "base_resource_group" {
  name     = "${var.app_name}-resource-group-${var.environment}"
  location = "eastus"

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}

module "mysql" {
  source              = "./mysql"
  app_name            = var.app_name
  environment         = var.environment
  mysql_password      = var.mysql_password
  location            = azurerm_resource_group.base_resource_group.location
  resource_group_name = azurerm_resource_group.base_resource_group.name
  depends_on          = [azurerm_resource_group.base_resource_group]
}
module "storage" {
  source              = "./storage"
  app_name            = var.app_name
  environment         = var.environment
  location            = azurerm_resource_group.base_resource_group.location
  resource_group_name = azurerm_resource_group.base_resource_group.name
}