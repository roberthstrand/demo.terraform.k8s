# Create namespaces
resource "kubernetes_namespace" "monitoring" {
    depends_on = [azurerm_kubernetes_cluster.k8s]
    metadata {
        labels = {
            mylabel = "monitoring"
        }
        name = "monitoring"
    }
}
resource "kubernetes_deployment" "prometheus" {
    depends_on = [kubernetes_namespace.monitoring]
    metadata {
        name = "prometheus"
        labels = {
            test = "prometheus"
        }
        namespace = "monitoring"
    }
        spec {
            replicas = 3
            selector {
                match_labels = {
                    test = "prometheus"
                }
            }
            template {
                metadata {
                    labels = {
                        test = "prometheus"
                    }
                }
            spec {
                container {
                    image = "prom/prometheus:v2.18.0"
                    name  = "prometheus"
                    resources {
                        limits {
                            cpu    = "0.5"
                            memory = "512Mi"
                        }
                        requests {
                            cpu    = "250m"
                            memory = "50Mi"
                        }
                    }
                }
            }
        }
    }
}
