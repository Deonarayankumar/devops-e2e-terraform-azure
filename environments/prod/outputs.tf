output "resource_group_name" { value = azurerm_resource_group.main.name }
output "app_url" { value = module.app.app_url }
output "vnet_id" { value = module.network.vnet_id }
