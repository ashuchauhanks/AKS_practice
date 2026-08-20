environment  = "prod"
location     = "eastus"
project_name = "aks-prod"

vnet_address_space = ["10.20.0.0/16"]

subnets = {
  "aks-subnet" = {
    address_prefixes                  = ["10.20.1.0/24"]
    private_endpoint_network_policies = "Enabled"
  }
  "iaas-subnet" = {
    address_prefixes                  = ["10.20.2.0/24"]
    private_endpoint_network_policies = "Enabled"
  }
}

# Production System Node Pool (Auto-scaling 2 to 4 nodes across Availability Zones)
system_node_pool = {
  name                 = "syspool"
  vm_size              = "Standard_D2s_v7"
  node_count           = 2
  os_disk_size_gb      = 50
  enable_auto_scaling  = true
  min_count            = 2
  max_count            = 4
  only_critical_addons = true
  zones                = ["1", "2", "3"]
}

# Production Worker Node Pools
user_node_pools = {
  "workpool1" = {
    vm_size             = "Standard_D2s_v7"
    node_count          = 2
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
    priority            = "Regular"
    zones               = ["1", "2", "3"]
    node_labels = {
      "role" = "worker"
      "env"  = "prod"
    }
  }
}

tags = {
  Owner       = "DevOps-Team"
  CostCenter  = "Prod-202"
  Environment = "prod"
}
