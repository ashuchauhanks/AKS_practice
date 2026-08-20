env_name   = "prod"
app_name   = "entaks"
location   = "East US"
dns_prefix = "aksprod"
sku_tier   = "Standard"

vnet_address_space    = ["10.1.0.0/16"]
subnet_address_prefix = ["10.1.1.0/24"]

default_node_pool = {
  name       = "systempool"
  node_count = 3
  vm_size    = "Standard_DS2_v2"
}

additional_node_pools = {
  workload1 = {
    node_count = 2
    vm_size    = "Standard_DS3_v2"
  }
}

network_profile = {
  network_plugin    = "azure"
  load_balancer_sku = "standard"
  network_policy    = "azure"
}
