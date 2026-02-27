data "local_file" "kube_config" {
  filename = pathexpand("~/.kube/config")
}

locals {
  kube_config = yamldecode(data.local_file.kube_config.content)
}
