## Create the resource group that we will use for kubernetes
resource "azurerm_resource_group" "k8s" {
  name     = "${var.name}-rg"
  location = var.location
  tags     = var.tags
}
