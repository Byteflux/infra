terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.19.0"
    }
  }
}

module "cluster" {
  source = "./modules/cluster-local"
}

provider "kubectl" {
  host                   = module.cluster.host
  client_certificate     = module.cluster.client_certificate
  client_key             = module.cluster.client_key
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
  token                  = module.cluster.token
}

provider "helm" {
  kubernetes = {
    host                   = module.cluster.host
    client_certificate     = module.cluster.client_certificate
    client_key             = module.cluster.client_key
    cluster_ca_certificate = module.cluster.cluster_ca_certificate
    token                  = module.cluster.token
  }
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
  yaml_body  = file("${path.root}/manifests/argo-root-app.yaml")
}
