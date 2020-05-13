resource "helm_release" "prometheus" {
    name            = "prometheus"
    chart           = "prometheus-operator"
    repository      = "https://charts.bitnami.com/bitnami"
    namespace       = "monitoring"

}