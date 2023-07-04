resource "azurerm_mysql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resourcegroup_name
  location                     = var.location
  administrator_login          = "mysqladmin"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"

  tags = {
    project     = "Uni"
  }
}

resource "azurerm_mysql_database" "sql_database" {
  name                = var.sql_database_name
  resource_group_name = var.resourcegroup_name
  server_name         = azurerm_mysql_server.sql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

output "sql_hostname" {
  value = azurerm_mysql_server.sql_server.fqdn
}