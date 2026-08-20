output "resource_group_name" {
  value       = data.azurerm_resource_group.this.name
  description = "Resource Group Name fetched via DATA block"
}

output "aks_cluster_name" {
  value       = data.azurerm_kubernetes_cluster.this.name
  description = "AKS Cluster Name fetched via DATA block"
}

output "aks_cluster_id" {
  value       = data.azurerm_kubernetes_cluster.this.id
  description = "AKS Cluster ID fetched via DATA block"
}

output "aks_managed_identity_principal_id" {
  value       = data.azurerm_kubernetes_cluster.this.identity[0].principal_id
  description = "AKS Cluster Managed Identity Principal ID fetched via DATA block"
}

output "vnet_id" {
  value       = data.azurerm_virtual_network.this.id
  description = "VNet ID fetched via DATA block"
}

output "aks_subnet_id" {
  value       = data.azurerm_subnet.aks.id
  description = "AKS Subnet ID fetched via DATA block"
}

output "get_credentials_command" {
  value       = "az aks get-credentials --resource-group ${data.azurerm_resource_group.this.name} --name ${data.azurerm_kubernetes_cluster.this.name}"
  description = "Azure CLI command to configure kubectl"
}
