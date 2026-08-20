environment  = "dev"
location     = "eastus"
project_name = "aks-dev"

vnet_address_space = ["10.10.0.0/16"]

subnets = {
  "aks-subnet" = {
    address_prefixes                  = ["10.10.1.0/24"]
    private_endpoint_network_policies = "Enabled"
  }
  "iaas-subnet" = {
    address_prefixes                  = ["10.10.2.0/24"]
    private_endpoint_network_policies = "Enabled"
  }
}

# 1 System Node (Master/System Addons Pool) - Supported Azure VM Size (Standard_D2s_v7)
system_node_pool = {
  name                 = "syspool"
  vm_size              = "Standard_D2s_v7"
  node_count           = 1
  os_disk_size_gb      = 30
  enable_auto_scaling  = false
  only_critical_addons = true
}

# 1 Worker Node Pool - Supported Azure VM Size (Standard_D2s_v7)
user_node_pools = {
  "workpool1" = {
    vm_size             = "Standard_D2s_v7"
    node_count          = 1
    os_disk_size_gb     = 30
    enable_auto_scaling = false
    priority            = "Regular"
    node_labels = {
      "role" = "worker"
      "env"  = "dev"
    }
  }
}

tags = {
  Owner       = "DevOps-Team"
  CostCenter  = "Dev-101"
  Environment = "dev"
}
