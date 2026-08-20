env_name   = "dev"
app_name   = "entaks"
location   = "East US"
dns_prefix = "aksdev"
sku_tier   = "Free"

vnet_address_space    = ["10.0.0.0/16"]
subnet_address_prefix = ["10.0.1.0/24"]

default_node_pool = {
  name       = "systempool"
  node_count = 1
  vm_size    = "Standard_DS2_v2"
}

additional_node_pools = {
  userpool = {
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }
}

network_profile = {
  network_plugin    = "azure"
  load_balancer_sku = "standard"
  network_policy    = "azure"
}
