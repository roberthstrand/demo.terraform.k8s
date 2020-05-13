# Initialize the providers that we need
provider "azurerm" {
    features {}
}
provider "azuread" {}

# Set up the kubernetes provider
provider "kubernetes" {
    load_config_file       = "false"
    host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
    username               = azurerm_kubernetes_cluster.k8s.kube_config.0.username
    password               = azurerm_kubernetes_cluster.k8s.kube_config.0.password
    client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
}

# Set up the helm provider against same cluster
provider "helm" {
    version        = "~> 0.10.4"
    kubernetes {
        host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
        client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
        client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
        cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
    }
}