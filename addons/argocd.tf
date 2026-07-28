#TEST

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  version    = "7.7.11" # pin, check for latest before using

  values = [
    yamlencode({
      server = {
        service = {
          type = "LoadBalancer" # swap for ClusterIP + ALB ingress later
        }
      }
    })
  ]

  depends_on = [kubernetes_namespace.argocd]
}
