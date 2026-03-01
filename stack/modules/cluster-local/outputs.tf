output "config" {
  value     = local.kube_config
  sensitive = true
}

output "host" {
  value     = local.kube_config.clusters[0].cluster.server
  sensitive = true
}

output "client_certificate" {
  value     = base64decode(local.kube_config.users[0].user["client-certificate-data"])
  sensitive = true
}

output "client_key" {
  value     = base64decode(local.kube_config.users[0].user["client-key-data"])
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = base64decode(local.kube_config.clusters[0].cluster["certificate-authority-data"])
  sensitive = true
}

output "token" {
  value     = null
  sensitive = true
}
