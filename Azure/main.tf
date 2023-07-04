provider "azurerm" {
   features {}
}

data "azurerm_client_config" "current" {
}

locals {
  today        = formatdate("YYYY-MM-DD", timestamp())
  api-cert     = filebase64("${path.cwd}/uni-cert.pfx")
  portal-cert  = filebase64("${path.cwd}/uni-portal-cert.pfx")
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.resourcegroup_name
  location = var.location
  tags     = {
    environment = var.environment
    project     = "Uni"
  }
}

module "keyvault" {
  source                          = "./modules/keyvault"
  keyvault_name                   = var.keyvault_name
  resourcegroup_name              = var.resourcegroup_name
  location                        = var.location
  cert                            = local.api-cert
  portal-cert                     = local.portal-cert
}

module "redis" {
  source                          = "./modules/Redis"
  redis_name                      = var.redis_name
  resourcegroup_name              = var.resourcegroup_name
  location                        = var.location
  environment                     = var.environment
}

module "sql" {
  source                          = "./modules/SQL"
  sql_server_name                 = var.sql_server_name
  sql_database_name               = var.sql_database_name
  resourcegroup_name              = var.resourcegroup_name
  location                        = var.location
}

module "Container_Registry" {
  source                          = "./modules/Container-Registry"
  resourcegroup_name              = var.resourcegroup_name
  location                        = var.location
  container_registry_name         = var.container_registry_name
}

module "app_service" {
  source                          = "./modules/App-Service"
  app_name                        = var.app_name
  app_plan_name                   = var.app_plan_name
  resourcegroup_name              = var.resourcegroup_name
  keyvault_name                   = var.keyvault_name
  environment                     = var.environment
//  redis_access_key                = module.redis.redis_primary_access_key
  location                        = var.location
  sql_server_name                 = var.sql_server_name
  sql_database_name               = var.sql_database_name
  redis_name                      = var.redis_name
  api-cert-id                     = module.keyvault.api_cert_id
  keyvault-id                     = module.keyvault.key_vault_id

    depends_on = [
    module.keyvault
  ]
}
