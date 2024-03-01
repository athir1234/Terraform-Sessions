resource "azurerm_resource_group" "stgaccntrg" {
  name     = "stgaccntrg"
  location = "East US"
}

resource "azurerm_storage_account" "stgaccntrg1" {

  name                     = var.storageaccount1
  resource_group_name      = azurerm_resource_group.stgaccntrg.name
  location                 = azurerm_resource_group.stgaccntrg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "stgaccntrg" {
  count = 5
  name                  = format("%s%s",var.container,"${count.index}")
  storage_account_name  = azurerm_storage_account.stgaccntrg1.name
  container_access_type = "private"
}

resource "azurerm_storage_account" "stgaccntrg2" {

  name                     = var.storageaccount2
  resource_group_name      = azurerm_resource_group.stgaccntrg.name
  location                 = azurerm_resource_group.stgaccntrg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}


resource "azurerm_storage_container" "stgaccntrg2" {
  count = 6
  name                  = format("%s%s",var.container,"${count.index}")
  storage_account_name  = azurerm_storage_account.stgaccntrg2.name
  container_access_type = "private"
}

output "storagaccnt1" {
  value = [azurerm_storage_account.stgaccntrg1.name,azurerm_storage_account.stgaccntrg2.name,azurerm_storage_container.stgaccntrg[*].name,
  azurerm_storage_container.stgaccntrg2[*].name]
}