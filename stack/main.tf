module "cluster" {
  source = "./modules/cluster-${var.cluster_provider}"
}

resource "helm_release" "argo" {
  depends_on       = [module.cluster]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "9.4.5"
  namespace        = "argocd"
  create_namespace = true
  atomic           = true
  cleanup_on_fail  = true
}

resource "kubectl_manifest" "argo_root_app" {
  depends_on = [helm_release.argo]
  yaml_body  = file("${path.root}/root-app.yaml")
}
