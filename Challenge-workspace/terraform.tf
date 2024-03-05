terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstaten72gl"
    container_name       = "tfstate1"
    key                  = "statefile-workspace"
    access_key           = "zy2QWKFMXAqTk8JU7YmbEIrDe2cSG7Pz/ob8miNZIKyye7ObyT2tMjSBMx2RFyIVgGsNuQg59ksx+AStEDmLmw==" # Replace with your storage account access key
     }
}