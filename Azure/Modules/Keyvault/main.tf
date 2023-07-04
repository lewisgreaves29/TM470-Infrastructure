data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.resourcegroup_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
    ]

    secret_permissions = [
      "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
    ]

    certificate_permissions = [
      "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
    ]
  }
}

resource "azurerm_key_vault_certificate" "api-cert" {
  name         = "uni-api-certificate"
  key_vault_id = azurerm_key_vault.keyvault.id

  certificate {
    contents = var.cert
    password = "!Location!10"
  }
}

resource "azurerm_key_vault_certificate" "portal-cert" {
 name         = "uni-portal-certificate"
 key_vault_id = azurerm_key_vault.keyvault.id

 certificate {
   contents = var.portal-cert
   password = "!Location!10"
 }
  depends_on = [
    azurerm_key_vault_certificate.api-cert
  ]
}

output "key_vault_id" {
  value = azurerm_key_vault.keyvault.id
}

output "api_cert_id" {
  value = azurerm_key_vault_certificate.api-cert.id
}