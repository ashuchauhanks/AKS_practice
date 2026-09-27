# 🚀 AKS & Kubernetes Hands-on Practice

This repository contains my hands-on practice with **Kubernetes and Azure Kubernetes Service (AKS)**.

I created these examples while learning and testing different Kubernetes concepts in a real AKS environment. Instead of keeping every small practice in a separate repository, I have kept them together here so that the complete learning journey is available in one place.

The folder names are organized by **practice date and topic**, making it easy to understand what was explored at each stage.

---

## 🎯 What I Practiced

The main focus of this repository is not just creating Kubernetes YAML files, but understanding how different Kubernetes resources work together.

The major areas covered are:

- Kubernetes Namespaces
- Pod networking
- Network Policies
- Kubernetes Secrets
- Pod volumes
- Azure Disk
- Azure File
- CSI Drivers
- Persistent Volumes (PV)
- Persistent Volume Claims (PVC)
- StorageClass
- Static and dynamic storage provisioning
- ReplicaSets
- Deployments
- Services
- Ingress
- Ingress Controller
- Host-based routing
- Azure Application Gateway for Containers
- Microservice deployment and ingress

---

# 📂 Practice Areas

## 1. Pod, Namespace & Network Policy

Folder:

`001_03-07-2026_k8s_pod-networkpoicy-namspace-yml`

This was focused on understanding how Kubernetes separates workloads using namespaces and how network communication between Pods can be controlled.

### Key concepts practiced

- Creating and using Kubernetes Namespaces
- Deploying Pods inside specific namespaces
- Pod labels and selectors
- NetworkPolicy
- Ingress traffic rules
- Egress traffic rules
- Pod-to-Pod communication
- Namespace-based traffic rules
- IP/CIDR based traffic rules
- Allowing and restricting specific ports
- Understanding default network behavior

The main objective was to understand how Kubernetes networking can be controlled at the workload level instead of allowing every Pod to communicate freely.

---

# 🔐 2. Pod Volumes & Kubernetes Secrets

Folder:

`002_12-07-2026_k8s-pod-volume-secret-yml`

This practice focused on connecting application Pods with storage and configuration data.

### Key concepts practiced

- Kubernetes Volumes
- `volumeMounts`
- Mounting volumes inside containers
- Sharing data through volumes
- Kubernetes Secrets
- Passing Secret values to Pods
- Using Secrets as environment variables
- Using Secrets as mounted files
- Understanding the relationship between Pod, container and volume

The goal was to understand how application configuration and data can be separated from the container image.

---

# ☁️ 3. Azure File with CSI Driver

Folder:

`003_19-07-2026_k8s-pod-spec.vol.csidriver(azfile)-secret-yml`

Here the practice moved from basic Kubernetes volumes to **Azure-managed storage through the CSI driver**.

### Key concepts practiced

- Azure File
- Azure File CSI Driver
- CSI-based volume mounting
- Pod volume configuration
- Storage credentials through Kubernetes Secrets
- Mounting Azure File inside Pods
- Understanding the relationship between:
  - Pod
  - Volume
  - Secret
  - CSI Driver
  - Azure Storage

This helped in understanding how Kubernetes communicates with external cloud storage through CSI instead of relying only on built-in volume plugins.

---

# 💾 4. Azure Disk + Azure File + Managed Identity

Folder:

`004_21-07-2026_k8s-pod-spec.vol.csidriver(azdisk+azfile)--MI+Secret-yml`

This practice went deeper into Azure storage integration by working with both **Azure Disk and Azure File**, along with identity and Secret-based authentication concepts.

### Key concepts practiced

- Azure Disk
- Azure File
- CSI Driver
- Managed Identity
- Kubernetes Secret
- Storage authentication
- Pod volume configuration
- Mounting cloud storage into workloads
- Comparing block storage and shared file storage

This helped in understanding that different workloads may require different storage models depending on how the application consumes data.

---

# 📦 5. Azure File PV + PVC

Folder:

`005_21-07-2026_k8s_pod-pv(spec.azfile)-pvc-secret-namspace-yml`

This section focused on the Kubernetes persistent storage model using Azure File.

### Key concepts practiced

- PersistentVolume (PV)
- PersistentVolumeClaim (PVC)
- Azure File
- Namespace
- Secret
- Volume mounting
- PV and PVC relationship
- Storage capacity
- Access modes
- Storage lifecycle

The important part here was understanding that the application Pod does not directly manage the underlying storage. The Pod consumes a PVC, while the PVC connects to the underlying PersistentVolume.

---

# 💽 6. Azure Disk PV + PVC

Folder:

`006_21-07-2026_k8s_pod-pv(spec.azdisk)-pvc-secret-namspace-yml_Not execute-CSI drivv...`

This practice focused on persistent storage using **Azure Managed Disk**.

### Key concepts practiced

- Azure Disk
- PersistentVolume
- PersistentVolumeClaim
- Namespace
- Pod volume mounting
- Storage capacity
- Access modes
- Persistent storage lifecycle
- Understanding node/storage relationships

This was also useful for understanding the difference between Azure Disk and Azure File from a Kubernetes workload perspective.

---

# 🔌 7. Azure Disk CSI Driver + PV/PVC

Folder:

`007_16-07-2026_k8s_pod-pv(spec.csi-azdisk)-pvc-namspace-yml`

Here the focus was specifically on the **CSI-based Azure Disk integration**.

### Key concepts practiced

- CSI driver
- Azure Disk CSI
- PersistentVolume
- PersistentVolumeClaim
- Namespace
- Storage configuration
- Pod volume mounting
- CSI-based storage lifecycle

CSI is important because it provides a standard interface for Kubernetes to work with external storage systems. :contentReference[oaicite:2]{index=2}

---

# 📁 8. Azure File CSI Driver + PV/PVC

Folder:

`008_23-07-2026_k8s_pod-pv(spec.csi-azfile)-pvc-namspace-yml`

This practice focused on using **Azure File through CSI with Kubernetes PV/PVC**.

### Key concepts practiced

- Azure File CSI
- PersistentVolume
- PersistentVolumeClaim
- Namespace
- Storage mounting
- Shared file storage
- CSI driver configuration
- Pod-to-storage relationship

This was useful for understanding shared storage scenarios where multiple workloads may need access to the same filesystem.

---

# ⚙️ 9. Azure File StorageClass + PVC

Folder:

`009_23-07-2026_k8s_pod-pv(storageclass-azfile)-pvc-namspace-yml`

This moved the practice from manually defining storage to understanding **StorageClass-based provisioning**.

### Key concepts practiced

- StorageClass
- Azure File CSI
- Dynamic provisioning
- PersistentVolumeClaim
- Provisioner
- Storage parameters
- Reclaim policy
- Volume binding
- Pod consumption of dynamically provisioned storage

A StorageClass defines how storage should be provisioned, while a PVC requests storage from that class. :contentReference[oaicite:3]{index=3}

---

# 💽 10. Azure Disk StorageClass + PVC

Folder:

`010_24-07-2026_k8s_pod-pv(storageclass-azdisk)-pvc-namspace-yml`

This practice continued the StorageClass concept with Azure Disk.

### Key concepts practiced

- Azure Disk CSI
- StorageClass
- Dynamic volume provisioning
- PVC
- Storage parameters
- Provisioner
- Reclaim policy
- Volume binding
- Pod volume consumption

The main learning here was understanding how applications can request storage through a PVC without having to manually create every PersistentVolume.

---

# 🔄 11. ReplicaSet & Deployment

Folder:

`011_24072026_workload_replicaset_deployment`

This section focused on Kubernetes workload management.

### Key concepts practiced

- ReplicaSet
- Deployment
- Pod replicas
- Desired state
- Replica management
- Pod replacement
- Labels and selectors
- Deployment-to-ReplicaSet relationship
- Updating application versions
- Declarative workload management

The focus was to understand why Deployments are generally used to manage application workloads instead of creating individual Pods manually.

---

# 🌐 12. Deployment + Service + Ingress Controller

Folder:

`012_27072026_workload_replicaset_deployment_service_ingresscontroller-yml`

This practice connected the workload and networking layers.

### Key concepts practiced

- Deployment
- ReplicaSet
- Pods
- Service
- ClusterIP
- Service selectors
- Backend Pods
- Ingress
- Ingress Controller
- HTTP routing
- External application access
- Request flow from client to Ingress → Service → Pod

Kubernetes Services provide a stable endpoint for changing backend Pods, while Ingress provides HTTP/HTTPS routing based on hosts and paths. :contentReference[oaicite:4]{index=4}

---

# ☁️ 13. Ingress + Azure Application Gateway for Containers

Folder:

`013_02082026_workload_replicaset_deployment_service_ingress-AGC-HostBase-yml`

This practice moved towards a more Azure-specific ingress implementation.

### Key concepts practiced

- Kubernetes Deployment
- Service
- Ingress
- Azure Application Gateway for Containers
- Host-based routing
- Ingress configuration
- Backend service mapping
- Application traffic flow
- Kubernetes workload exposure through Azure networking

The main focus was understanding how Kubernetes application routing can be integrated with Azure's application-layer networking.

---

# 🚀 14. Axion Microservice + Ingress

Folder:

`014_11082026_axion-microservice_ingresstopods`

This section brought multiple concepts together around a microservice-style workload.

### Key concepts practiced

- Microservice deployment
- Kubernetes Pods
- Deployments
- Services
- Ingress
- Pod-to-Service communication
- Service-to-Pod routing
- External application access
- Host/path based routing
- Troubleshooting application connectivity

This was a step towards understanding how a real application can be broken into workloads and exposed through Kubernetes networking.

---

# 🧠 What I Learned Through These Hands-on Exercises

Working through these examples helped me understand Kubernetes from different layers rather than learning individual commands in isolation.

### Networking

- How Pods communicate
- How Services provide stable access to Pods
- How Ingress routes external HTTP/HTTPS traffic
- How NetworkPolicies control allowed traffic
- How labels and selectors connect Kubernetes resources

### Storage

- Difference between Volume, PV and PVC
- Static vs dynamic provisioning
- Azure Disk vs Azure File
- CSI driver architecture
- StorageClass-based provisioning
- Access modes
- Storage lifecycle and reclaim behavior
- How Pods consume persistent storage

### Workloads

- Pods
- ReplicaSets
- Deployments
- Desired state
- Replica management
- Application updates

### Security & Configuration

- Kubernetes Secrets
- Secret-based storage access
- Namespace isolation
- Managed Identity concepts
- Network traffic restrictions

### Azure Integration

- Azure Disk
- Azure File
- Azure CSI Drivers
- Managed Identity
- Azure Application Gateway for Containers
- AKS workload exposure

---

# 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Kubernetes | Container orchestration |
| Azure Kubernetes Service (AKS) | Managed Kubernetes |
| Kubernetes YAML | Resource configuration |
| Azure Disk | Persistent block storage |
| Azure File | Shared file storage |
| CSI Drivers | Kubernetes storage integration |
| PV / PVC | Persistent storage management |
| StorageClass | Storage provisioning |
| Kubernetes NetworkPolicy | Pod traffic control |
| Secrets | Sensitive configuration |
| Deployments | Application workload management |
| ReplicaSets | Pod replica management |
| Services | Stable application networking |
| Ingress | HTTP/HTTPS routing |
| Azure Application Gateway for Containers | Azure-based application ingress |
| Git & GitHub | Version control |

---

# 📁 Repository Philosophy

I have kept these examples together intentionally.

Each folder represents a particular concept or problem that I worked on while learning Kubernetes and AKS.

The idea is simple:

**Learn the concept → Write the YAML → Deploy it → Test the behavior → Troubleshoot → Understand what is happening**

This repository is therefore more of a **hands-on Kubernetes lab** than a collection of production-ready manifests.

---

## 👨‍💻 About Me

**Ashutosh Singh**

DevOps Engineer | Azure | AWS | Kubernetes | Terraform | CICD Pipeline

I prefer learning DevOps technologies by building and testing things practically rather than only going through theory.

### Connect With Me

- GitHub: https://github.com/ashuchauhanks
- LinkedIn: https://www.linkedin.com/in/ashutoshsinghpbh

---

⭐ If you are also learning Kubernetes or AKS, feel free to explore the examples and use them as a reference.
