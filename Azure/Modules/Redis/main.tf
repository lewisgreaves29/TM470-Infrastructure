resource "azurerm_redis_cache" "redis" {
 name                = var.redis_name
  location            = var.location
  resource_group_name = var.resourcegroup_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = true
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}

output "redis_primary_access_key" {
  value = azurerm_redis_cache.redis.primary_access_key
}

output "redis_hostname" {
  value = azurerm_redis_cache.redis.hostname
}