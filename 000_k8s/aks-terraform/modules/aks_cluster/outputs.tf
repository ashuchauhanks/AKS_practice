output "id" {
  value       = azurerm_kubernetes_cluster.this.id
  description = "The ID of the AKS cluster"
}

output "name" {
  value       = azurerm_kubernetes_cluster.this.name
  description = "The name of the AKS cluster"
}

output "kube_config_raw" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
  description = "Raw kubeconfig for cluster access"
}

output "kube_config_host" {
  value       = azurerm_kubernetes_cluster.this.kube_config[0].host
  sensitive   = true
  description = "Host URL of the Kubernetes API server"
}

output "principal_id" {
  value       = azurerm_kubernetes_cluster.this.identity[0].principal_id
  description = "Principal ID of the Managed Identity created for the AKS cluster"
}

output "oidc_issuer_url" {
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
  description = "OIDC Issuer URL for workload identity integration"
}
