
resource "time_sleep" "wait_60_seconds" {
  create_duration = "60s"
  depends_on = [
    azurerm_key_vault_access_policy.App_Service_Access
  ]
}

resource "azurerm_service_plan" "uni_app_service_plan" {
  name                = var.app_plan_name
  location            = var.location
  resource_group_name = var.resourcegroup_name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_app_service" "uni_app_service" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resourcegroup_name
  app_service_plan_id = azurerm_service_plan.uni_app_service_plan.id

  app_settings = {
    "Env" = var.environment
  }
  identity { type = "SystemAssigned" }
  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

//resource "azurerm_app_service_certificate" "uni-api-cert" {
//  name                   = "uni-api-cert"
//  resource_group_name    = var.resourcegroup_name
//  location               = var.location
//  key_vault_secret_id    = var.api_cert_id
//  depends_on = [
//    time_sleep.wait_60_seconds
//  ]

//}

resource "azurerm_app_service_custom_hostname_binding" "uni-hostname" {
  hostname            = "api.shorterurl.uk"
  app_service_name    = azurerm_app_service.uni_app_service.name
  resource_group_name = var.resourcegroup_name
}

//resource "azurerm_app_service_certificate_binding" "uni-binding" {
//  hostname_binding_id = azurerm_app_service_custom_hostname_binding.uni-hostname.id
//  certificate_id      = azurerm_app_service_certificate.uni-api-cert.id
//  ssl_state           = "SniEnabled"
//}

resource "azurerm_key_vault_access_policy" "App_Service_Access" {
  key_vault_id = var.keyvault-id
  tenant_id    = azurerm_app_service.uni_app_service.identity.0.tenant_id
  object_id    = azurerm_app_service.uni_app_service.identity.0.principal_id

    key_permissions = [
      "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
    ]

    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
    ]

    certificate_permissions = [
      "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
    ]
  depends_on = [
    azurerm_key_vault_access_policy.Microsoft_App_Service_Access
  ]
}

resource "azurerm_key_vault_access_policy" "Microsoft_App_Service_Access" {
  key_vault_id = var.keyvault-id
  tenant_id    = azurerm_app_service.uni_app_service.identity.0.tenant_id
  object_id    = "d2e2e0ee-d9d9-46cd-a3f6-f1882084423c"

    key_permissions = [
      "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
    ]

    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
    ]

    certificate_permissions = [
      "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
    ]
  depends_on = [
    azurerm_app_service.uni_app_service
  ]
}

output "app_object_id" {
  value = azurerm_app_service.uni_app_service.identity.0.principal_id
}

output "app_tenant_id" {
  value = azurerm_app_service.uni_app_service.identity.0.tenant_id
}