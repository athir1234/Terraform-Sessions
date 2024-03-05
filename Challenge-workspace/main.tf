resource "azurerm_resource_group" "appservice" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_service_plan" "serviceplan" {
  name                = var.planname
  location            = azurerm_resource_group.appservice.location
  resource_group_name = azurerm_resource_group.appservice.name

  sku_name = var.sku

  os_type = var.os
  tags = {
    env = join(":", "${toset(var.tag)}") 
  }
}


resource "azurerm_windows_web_app" "app_service" {
  name                = "appservice-${var.env}"
  location            = azurerm_resource_group.appservice.location
  resource_group_name = azurerm_resource_group.appservice.name
  service_plan_id     = azurerm_service_plan.serviceplan.id
  tags = {
    env = join(":", "${toset(var.tag)}")
  }
  site_config {
    always_on = false
  }
  app_settings = {

  }
  lifecycle {
    ignore_changes = [app_settings, tags]
  }
}

resource "azurerm_storage_account" "stgaccount" {
  name                     = var.stgname
  resource_group_name      = azurerm_resource_group.appservice.name
  location                 = azurerm_resource_group.appservice.location
  account_tier             = var.accounttier
  account_replication_type = var.rep

  tags = {
    env = join(":", "${toset(var.tag)}")
  }
}

output "serviceplanname-sku" {
  value = [azurerm_service_plan.serviceplan.name, azurerm_service_plan.serviceplan.tags, azurerm_windows_web_app.app_service.name,
  azurerm_storage_account.stgaccount.name]
}
