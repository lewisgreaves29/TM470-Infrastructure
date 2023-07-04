variable "resourcegroup_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The resource location"
  type        = string
}


variable "keyvault_name" {
  description = "The Keyvault name"
  type        = string
}

variable "cert" {
  description = "The base64 of the api cert"
  type        = string
}

variable "portal-cert" {
  description = "The base64 of the portal cert"
  type        = string
}