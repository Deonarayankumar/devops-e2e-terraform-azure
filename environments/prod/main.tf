terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  tags = merge(var.tags, { environment = var.environment })
}

resource "azurerm_resource_group" "main" {
  name     = "${var.name_prefix}-rg"
  location = var.location
  tags     = local.tags
}

module "network" {
  source              = "../../modules/network"
  name_prefix         = var.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.address_space
  app_subnet_prefix   = var.app_subnet_prefix
  tags                = local.tags
}

module "monitoring" {
  source              = "../../modules/monitoring"
  name_prefix         = var.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  retention_days      = var.log_retention_days
  tags                = local.tags
}

module "app" {
  source              = "../../modules/app"
  name_prefix         = var.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  plan_sku            = var.plan_sku
  always_on           = var.always_on
  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = module.monitoring.app_insights_connection_string
  }
  tags = local.tags
}
