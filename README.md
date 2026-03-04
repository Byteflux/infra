# infra

This repository contains infrastructure and service declarations for personal stuff and also serves as a way for me to learn more about Terraform and Kubernetes.

## Project Layout

Two distinct pieces make up the top level of this project:
- "The Stack" in `stack/`
- "Applications" in `apps/`

### The Stack

The `stack/` directory is the Terraform root module that defines the target infrastructure, which is currently just one Kubernetes cluster.

In addition to provisioning the infrastructure, this module also installs ArgoCD onto the cluster using Helm. Finally, an ArgoCD Root App is deployed onto the cluster in an "App of Apps" GitOps-based configuration.

### Applications

The `apps/` directory contains Kubernetes manifests that are managed by ArgoCD's Root App.

Application manifests are placed at the top-level of `apps/`. These top-level manifests usually declare one of two kinds of ArgoCD applications:

1. An app to be installed from a Helm chart.
2. An app that syncs from a subdirectory. For example `apps/envoy-gateway.yaml` declares an ArgoCD app configured to sync manifests from the subdirectory `apps/envoy-gateway/`.

#### Nested Applications

For apps that sync from a subdirectory, there should be a nested ArgoCD app manifest named `app.yaml` which declares the Helm-based app. For example, `apps/envoy-gateway/app.yaml` declares the app manifest for the Envoy Gateway Helm chart.

Additional related manifests should be placed in this subdirectory alongside `app.yaml`. For example, the Envoy Gateway app directory contains some additional manifests:

- **GatewayClass**: `apps/envoy-gateway/gateway-class.yaml`
- **Gateway**: `apps/envoy-gateway/gateway.yaml`
