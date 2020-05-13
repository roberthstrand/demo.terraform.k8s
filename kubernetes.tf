# Kubernetes 
## Setting up a new cluster through Azure Kubernetes Service

### Creating the cluster
resource "azurerm_kubernetes_cluster" "k8s" {
    name                = var.name
    location            = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name
    dns_prefix          = "k8s"
    ### Set up the default agent pool
    default_node_pool {
    name       = "pool"
    node_count = 1
    vm_size    = "Standard_F2s_v2" # B2s
    }
    ### Define the service principal
    service_principal {
    client_id     = azuread_service_principal.k8s.application_id
    client_secret = random_password.password.result
    }
    ### set the tags
    tags = var.tags
}
