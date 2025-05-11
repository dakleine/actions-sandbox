resource "kubernetes_manifest" "httproute_hello_app_route" {
  manifest = {
    "apiVersion" = "gateway.networking.k8s.io/v1beta1"
    "kind" = "HTTPRoute"
    "metadata" = {
      "name" = "app-route"
      "namespace" = "hello"
    }
    "spec" = {
      "parentRefs" = [
        {
          "name" = "external-gateway"
          "namespace" = "gateway-ns"
        },
      ]
      "rules" = [
        {
          "backendRefs" = [
            {
              "name" = "example-hello-loadbalancer"
              "port" = 80
            },
          ]
          "matches" = [
            {
              "path" = {
                "value" = "/"
              }
            },
          ]
        },
      ]
    }
  }
}