variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "plan_sku" { type = string }
variable "always_on" { type = bool default = false }
variable "app_settings" { type = map(string) default = {} }
variable "tags" { type = map(string) default = {} }
