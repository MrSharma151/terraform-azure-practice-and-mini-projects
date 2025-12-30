# 🚀 Azure VM Scale Set Mini Project (Terraform)

## 📌 Project Overview

This project demonstrates how to design and provision a **highly available, scalable web infrastructure on Microsoft Azure** using **Terraform**.
The infrastructure is built around an **Azure Virtual Machine Scale Set (VMSS)** placed behind an **Azure Standard Load Balancer**, following real-world cloud and DevOps best practices.

The goal of this project is to practice **Infrastructure as Code (IaC)** concepts, Azure networking fundamentals, and VMSS-based architectures commonly used in production environments.

---

## 🧱 Architecture Overview

**High-level architecture:**

```
Internet
   |
Public IP
   |
Azure Standard Load Balancer
   |
Backend Pool
   |
Virtual Machine Scale Set (VMSS)
   |
Subnet
   |
Virtual Network
```

---

## 🛠️ Technologies & Services Used

### Infrastructure as Code

* **Terraform (>= 1.5.0)**
* **AzureRM Provider (~> 3.x)**

### Azure Services

* Resource Group
* Virtual Network (VNet)
* Subnet
* Network Security Group (NSG)
* Public IP (Standard SKU)
* Azure Load Balancer (Standard)
* Load Balancer Backend Pool
* Load Balancer Health Probe
* Load Balancer Rules
* Virtual Machine Scale Set (Linux)
* NAT Gateway
* Azure Monitor Autoscale

---

## 📁 Project Structure

```text
.
├── providers.tf        # Terraform provider & backend configuration
├── main.tf             # Resource Group definition
├── network.tf          # Virtual Network & Subnet
├── security.tf         # Network Security Group & rules
├── lb.tf               # Load Balancer & Public IP
├── nat.tf              # NAT Gateway for outbound connectivity
├── vmss.tf             # Virtual Machine Scale Set
├── autoscale.tf        # VMSS autoscaling rules
├── variables.tf        # Input variables
├── terraform.tfvars    # Variable values
├── locals.tf           # Common tags and locals
├── outputs.tf          # Useful outputs
├── scripts/
│   └── startup.sh      # VM bootstrap script
└── README.md           # Project documentation
```

---

## 🌐 Networking Design

* A **private Virtual Network** is created with a dedicated subnet for the VM Scale Set.
* The subnet is protected by a **Network Security Group (NSG)**.
* Inbound traffic is **restricted** and allowed **only through the Azure Load Balancer**.
* A **NAT Gateway** is attached to the subnet to provide controlled outbound internet access.

---

## ⚖️ Load Balancer Design

* **Azure Standard Load Balancer** is used for production-grade behavior.
* A **Public IP** is attached to the Load Balancer frontend.
* A **Backend Address Pool** connects the Load Balancer to the VM Scale Set.
* **Health Probes** monitor VM instance health.
* **Load Balancer Rules** route traffic from frontend to backend instances.

---

## 🖥️ Virtual Machine Scale Set (VMSS)

* Linux-based VM Scale Set using **Ubuntu 22.04 LTS**.
* Stateless design suitable for horizontal scaling.
* Integrated with the Load Balancer backend pool.
* Uses **cloud-init (`custom_data`)** to bootstrap instances at launch.
* Password authentication is disabled; **SSH key–based access** is enforced.

---

## 📈 Autoscaling Configuration

Autoscaling is implemented using **Azure Monitor Autoscale**:

* **Minimum instances:** 1
* **Default instances:** 2
* **Maximum instances:** 3

### Scaling Rules

* Scale **out** when average CPU usage exceeds a defined threshold.
* Scale **in** when CPU usage drops below a lower threshold.
* Cooldown periods are configured to prevent rapid scaling.

---

## 🔐 Security Best Practices Applied

* No direct public access to VM instances.
* NSG restricts inbound traffic to Load Balancer only.
* Password authentication disabled.
* SSH access via public key.
* Centralized tagging for governance and cost tracking.

---

## 🏷️ Resource Tagging

All resources are tagged consistently using Terraform locals:

* `project`
* `environment`
* `managed_by`

This aligns with enterprise governance and cost-management practices.

---

## 📤 Outputs

The project exposes useful outputs such as:

* Resource Group name and location
* Virtual Network name
* Subnet details
* Load Balancer name and Public IP
* VMSS name and SKU
* Autoscale configuration name

These outputs make integration, debugging, and future extensions easier.

---

## 🚦 Deployment Flow

1. Terraform initializes provider and remote backend.
2. Resource Group is created.
3. Networking components (VNet, Subnet, NSG) are provisioned.
4. Load Balancer and Public IP are created.
5. NAT Gateway is attached to the subnet.
6. VM Scale Set is deployed and attached to the Load Balancer.
7. Autoscaling rules are applied.
8. Infrastructure reaches a stable, scalable state.

---

## 🎯 Key Learnings from This Project

* Designing scalable Azure architectures using VMSS
* Implementing Infrastructure as Code with Terraform
* Understanding Azure Load Balancer behavior
* Applying autoscaling strategies
* Managing dependencies and resource ordering in Terraform
* Real-world debugging and iteration on cloud infrastructure

---

## 📌 Future Enhancements

* Replace Load Balancer with Application Gateway
* Add HTTPS using Azure-managed certificates
* Centralized logging and monitoring
* CI/CD pipeline integration
* Blue/green or rolling deployment strategies

---

## 🧹 Cleanup

To destroy all resources and avoid ongoing costs:

```bash
terraform destroy
```

---

## 🏁 Conclusion

This project serves as a **hands-on, real-world Terraform + Azure VMSS practice** that closely resembles production infrastructure patterns.
It focuses on scalability, security, and maintainability — key skills expected from a DevOps or Cloud Engineer.

