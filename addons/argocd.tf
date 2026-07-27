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

resource "kubernetes_manifest" "petclinic_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "petclinic"
      namespace = kubernetes_namespace.argocd.metadata[0].name
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/Arjun-M-S/GitOps.git"
        targetRevision = "main"
        path           = "."
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default"
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = [
          "CreateNamespace=true"
        ]
      }
    }
  }

  depends_on = [helm_release.argocd]
}
