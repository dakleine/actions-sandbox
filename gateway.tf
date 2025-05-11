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
            "tls.crt" = var.gateway-crt
            "tls.key" = var.gateway-key
          }

          type = "kubernetes.io/tls"
       }
resource "kubernetes_manifest" "gateway_gateway_ns_external_gateway" {
  manifest = {
    "apiVersion" = "gateway.networking.k8s.io/v1beta1"
    "kind" = "Gateway"
    "metadata" = {
      "name" = "external-gateway"
      "namespace" = "gateway-ns"
    }
    "spec" = {
      "gatewayClassName" = "gke-l7-global-external-managed"
      "listeners" = [
        {
          "allowedRoutes" = {
            "namespaces" = {
              "from" = "Selector"
              "selector" = {
                "matchLabels" = {
                  "kubernetes.io/metadata.name" = "hello"
                }
              }
            }
          }
          "name" = "https"
          "port" = 443
          "protocol" = "HTTPS"
          "tls" = {
            "certificateRefs" = [
              {
                "name" = "gateway-secret"
              },
            ]
          }
        },
      ]
    }
  }
}