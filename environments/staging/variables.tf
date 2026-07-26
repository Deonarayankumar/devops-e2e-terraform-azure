variable "name_prefix" { type = string }
variable "location" { type = string default = "eastus" }
variable "environment" { type = string }
variable "address_space" { type = list(string) }
variable "app_subnet_prefix" { type = string }
variable "plan_sku" { type = string }
variable "always_on" { type = bool default = false }
variable "log_retention_days" { type = number default = 30 }
variable "tags" { type = map(string) default = {} }
