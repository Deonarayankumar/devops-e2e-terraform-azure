variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "address_space" { type = list(string) }
variable "app_subnet_prefix" { type = string }
variable "tags" { type = map(string) default = {} }
