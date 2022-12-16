# DEFINING RESOURCE - RESOURCE GROUP

resource "azurerm_resource_group" "main-rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# DEFINING RESOURCE - RESOURCE STORAGE ACCOUNT

resource "azurerm_storage_account" "mssql-storage" {
  name                     = "cpsmssqlstorage"
  resource_group_name      = azurerm_resource_group.main-rg.name
  location                 = azurerm_resource_group.main-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# DEFINING RESOURCE - RESOURCE MSSQL SERVER

resource "azurerm_mssql_server" "mssql-server" {
  name                         = "cpsmssqlserver"
  resource_group_name          = azurerm_resource_group.main-rg.name
  location                     = azurerm_resource_group.main-rg.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

# DEFINING RESOURCE - RESOURCE MSSQL DATABASE

resource "azurerm_mssql_database" "mssql-database" {
  name           = "cpsmssqldatabase"
  server_id      = azurerm_mssql_server.mssql-server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false

  tags = {
    Environment = "dev"
  }
}