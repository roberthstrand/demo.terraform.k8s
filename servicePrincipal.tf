## Create a Service Principal, and the necessary application
## docs: https://www.terraform.io/docs/providers/azuread/r/service_principal.html
resource "random_integer" "appnumber" {
    min = 1
    max = 4
}
resource "azuread_application" "kubeapp" {
    name = "kubeapp${random_integer.appnumber.result}"
}
resource "azuread_service_principal" "k8s" {
    application_id = azuread_application.kubeapp.application_id
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
    end_date_relative     = "24h"
}

output "display_name" {
    value = azuread_service_principal.k8s.display_name
}