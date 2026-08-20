# Enterprise Modular Azure Kubernetes Service (AKS) Terraform Repository

This repository provides a production-grade, modular Terraform architecture for deploying **Azure Kubernetes Service (AKS)** clusters across **Development (`dev`)** and **Production (`prod`)** environments.

---

## 📁 Project Directory Structure

```text
aks-terraform/
├── modules/                         # Isolated, single-responsibility resource modules
│   ├── resource_group/              # Azure Resource Group module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vnet/                        # Virtual Network & Subnets module (uses for_each)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── log_analytics/               # Log Analytics Workspace module (Container Insights)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── aks_cluster/                 # AKS Cluster module (System Node Pool, Azure CNI, Identity, OIDC)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── user_node_pool/              # Worker Node Pool module (uses for_each)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── role_assignment/             # RBAC Role Assignments module (uses for_each)
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/                    # Environment-specific deployment root directories
    ├── dev/                         # Development Environment
    │   ├── main.tf                  # Module orchestration
    │   ├── locals.tf                # Local variables & tag merging
    │   ├── variables.tf             # Input variables & validation rules
    │   ├── outputs.tf               # Terraform outputs & CLI snippets
    │   ├── providers.tf             # AzureRM provider (~> 4.0 / 5.0) & backend setup
    │   └── terraform.tfvars         # Prefilled values (1 System Node + 1 Worker Node, East US)
    └── prod/                        # Production Environment
        ├── main.tf                  # Module orchestration
        ├── locals.tf                # Local variables & tag merging
        ├── variables.tf             # Input variables & validation rules
        ├── outputs.tf               # Terraform outputs & CLI snippets
        ├── providers.tf             # AzureRM provider (~> 4.0 / 5.0) & backend setup
        └── terraform.tfvars         # Prefilled values (Multi-AZ, Autoscaling, High Availability)
```

---

## 🛠️ Key Features & Best Practices Demonstrated

| Feature | Implementation Detail |
| :--- | :--- |
| **Modular Structure** | Each Azure resource type is encapsulated in its own directory within `modules/`. |
| **Multi-Environment** | Separate root configurations for `dev` and `prod` with isolated state management. |
| **`locals` Block** | Standardized naming convention (`rg-*`, `vnet-*`, `aks-*`), tag merging (`Environment`, `ManagedBy`, `Project`). |
| **`for_each`** | Subnet creation in `vnet`, worker node pool creation in `user_node_pool`, and role assignments in `role_assignment`. |
| **`data` Block** | Querying Azure `subscription` and `client_config` metadata. |
| **`module` Block** | Explicit parameter passing and dependency chaining (`depends_on`). |
| **`output` Block** | Exposing cluster IDs, Resource Group names, VNet details, and Azure CLI `get-credentials` commands. |
| **`terraform.tfvars`** | Prefilled ready-to-run configurations tailored for free trial / low-cost quotas (`dev`) and HA autoscaling (`prod`). |
| **Provider Constraint** | Configured for `hashicorp/azurerm ~> 4.0` (compatible with 4.x/5.x releases). |

---

## 🚀 Quick Start Guide

### 1. Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) `>= 1.5.0` installed.
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) installed.
- An active Azure subscription.

### 2. Authenticate with Azure
```bash
az login
az account set --subscription "<YOUR_SUBSCRIPTION_ID_OR_NAME>"
```

### 3. Deploy Development (`dev`) Environment
The `dev` environment is configured with:
- Location: **`eastus`** (free trial / standard quota friendly)
- **1 System Node Pool** (`Standard_B2s` / 2 vCPU, 4GB RAM)
- **1 Worker Node Pool** (`Standard_B2s` / 2 vCPU, 4GB RAM)
- Total: **2 Nodes (4 vCPUs)** — fits easily within standard 10-20 vCPU free subscription limits.

```bash
cd environments/dev

# Initialize Terraform
terraform init

# Review execution plan
terraform plan

# Apply infrastructure
terraform apply
```

### 4. Connect to AKS Cluster
Once `terraform apply` finishes, fetch credentials using the generated output command:
```bash
az aks get-credentials --resource-group rg-aks-dev-dev --name aks-aks-dev-dev
kubectl get nodes
```

### 5. Clean Up (Teardown)
```bash
terraform destroy
```
