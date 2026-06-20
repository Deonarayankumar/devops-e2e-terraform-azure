output "app_url" { value = "https://${azurerm_linux_web_app.this.default_hostname}" }
output "app_id" { value = azurerm_linux_web_app.this.id }
