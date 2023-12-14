resource "azurerm_mysql_server" "mysql_server" {
  name                = "${var.app_name}-mysqlserver-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login              = "mysql_admin_${var.environment}"
  administrator_login_password     = var.mysql_password
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}

resource "azurerm_mysql_firewall_rule" "main" {
  name                = "${var.app_name}-mysql-firewall-${var.environment}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}


resource "azurerm_mysql_firewall_rule" "with_public_access" {
  name                = "${var.app_name}-mysql-firewall-public-${var.environment}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_mysql_database" "greensupermarket_dev_db" {
  name                = "${var.app_name}-db-${var.environment}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
