terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.30.0"
    }
  }
}

resource "vultr_kubernetes" "vke" {
  label   = var.vke_label
  version = var.k8_version
  region  = var.region

  node_pools {
    label         = var.np_label
    plan          = var.np_plan
    node_quantity = var.np_node_quantity
    min_nodes     = var.np_min_nodes
    max_nodes     = var.np_max_nodes
    auto_scaler   = var.np_auto_scale
  }
}

locals {
  kube_config = yamldecode(base64decode(vultr_kubernetes.vke.kube_config))
}
