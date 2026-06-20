resource "azurerm_service_plan" "this" {
  name                = "${var.name_prefix}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.plan_sku
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "${var.name_prefix}-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id
  tags                = var.tags

  site_config {
    always_on = var.always_on
    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = merge(var.app_settings, {
    "WEBSITES_PORT" = "8000"
  })
}
