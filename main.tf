# Initialize the providers that we need
provider "azurerm" {
  features {}
}
provider "azuread" {}
## Create the resource group that we will use for kubernetes
resource "azurerm_resource_group" "k8s" {
  name     = "var.prefix-k8s-rg"
  location = var.location
}
## Create a Service Principal, and the necessary application
## docs: https://www.terraform.io/docs/providers/azuread/r/service_principal.html
resource "azuread_application" "kubeApp" {
  name = "kubeApp"
}
resource "azuread_service_principal" "k8s" {
  application_id = azuread_application.kubeApp.application_id
}
## Create a password for the service principal with the *random_password* resource
## and use it for the service principal
resource "random_password" "password" {
    length  = 32
    special = true
}
resource "azuread_service_principal_password" "k8s" {
  service_principal_id  = azuread_service_principal.k8s.id
  value                 = random_password.password.result
}