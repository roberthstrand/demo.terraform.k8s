# Create namespaces
resource "kubernetes_namespace" "monitoring" {
    metadata {
    labels = {
        mylabel = "monitoring"
    }
    name = "monitoring"
    }
}