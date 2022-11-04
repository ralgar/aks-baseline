# Split multi-doc YAML with
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest
data "kubectl_file_documents" "flux_install" {
  content = file("${path.root}/../cluster/system/flux-cd/flux-install.yaml")
}

# Apply manifests
resource "kubectl_manifest" "flux_install" {
  for_each  = data.kubectl_file_documents.flux_install.manifests
  yaml_body = each.value
}
