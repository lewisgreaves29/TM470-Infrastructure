variable "resourcegroup_name" {
  description = "The resource group name"
  type        = string
}

variable "app_name" {
  description = "The app name"
  type        = string
}

variable "app_plan_name" {
  description = "The app service plan name"
  type        = string
}

variable "keyvault_name" {
  description = "The keyvault name"
  type        = string
}

variable "redis_name" {
  description = "The redis cache name"
  type        = string
}

variable "sql_server_name" {
  description = "The sql server name"
  type        = string
}

variable "sql_database_name" {
  description = "The sql database name"
  type        = string
}

variable "location" {
  description = "The resource group location"
  type        = string
}

variable "environment" {
  description = "The environment name"
  type        = string
}

variable "api-cert-id" {
  description = "The environment name"
  type        = string
}

variable "keyvault-id" {
  description = "The environment name"
  type        = string
}

//variable "redis_access_key" {
//  description = "The environment name"
//  type        = string
//}