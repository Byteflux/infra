provider "kubernetes" {
  host                   = module.cluster.auth.host
  client_certificate     = module.cluster.auth.client_certificate
  client_key             = module.cluster.auth.client_key
  cluster_ca_certificate = module.cluster.auth.cluster_ca_certificate
  token                  = module.cluster.auth.token
}

provider "helm" {
  kubernetes = {
    host                   = module.cluster.auth.host
    client_certificate     = module.cluster.auth.client_certificate
    client_key             = module.cluster.auth.client_key
    cluster_ca_certificate = module.cluster.auth.cluster_ca_certificate
    token                  = module.cluster.auth.token
  }
}

module "cluster" {
  source = "./modules/cluster-local"
}

module "argo" {
  source = "./modules/argo"
}

module "argo_root_app" {
  source = "./modules/argo-root-app"
}
