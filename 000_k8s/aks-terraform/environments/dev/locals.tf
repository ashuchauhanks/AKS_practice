locals {
  name_prefix = "${var.project_name}-${var.environment}"

  resource_group_name = "rg-${local.name_prefix}"
  vnet_name           = "vnet-${local.name_prefix}"
  log_analytics_name  = "law-${local.name_prefix}"
  aks_cluster_name    = "aks-${local.name_prefix}"
  aks_dns_prefix      = "dns-${local.name_prefix}"

  common_tags = merge(var.tags, {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  })
}
