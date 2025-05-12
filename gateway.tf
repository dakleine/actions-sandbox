resource "kubernetes_namespace" "gateway-ns" {
  metadata {
    name = "gateway-ns"
  }
}

resource "kubernetes_secret" "cert" {
  metadata {
    name = "gateway-secret"
    namespace = "gateway-ns"
  }

  data = {
    "tls.crt" = base64decode(var.gateway-crt)
    "tls.key" = base64decode(var.gateway-key)
  }

  type = "kubernetes.io/tls"
}
