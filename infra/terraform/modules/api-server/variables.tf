variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "network_interface_ids" {
  type = list(string)
}