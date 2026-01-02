
---

# Azure Policy & Governance using Terraform

### Subscription-level Governance as Code (Mini Project)

---

## 📌 Project Overview

This project demonstrates **Azure Policy & Governance implemented using Terraform** following **Infrastructure as Code (IaC)** principles.

The goal of this mini project is to enforce **organization-wide governance rules** at the **subscription level** and validate policy enforcement using real tests.

This project focuses on:

* Governance
* Compliance
* Cost control
* Security best practices

---

## 🎯 Objectives

Using Terraform, this project implements:

* Custom Azure Policy Definitions
* Subscription-level Policy Assignments
* Governance enforcement using **Deny** effect
* Compliance testing using free Azure resources

---

## 🧱 Policies Implemented

### 1️⃣ Location Restriction Policy

Restricts resource creation to only approved regions:

**Allowed regions:**

* `eastus`
* `westus`

➡️ Any resource created outside these regions is **DENIED**.

---

### 2️⃣ VM Size Control Policy (Cost Governance)

Restricts Virtual Machine creation to cost-effective SKUs only:

**Allowed VM sizes:**

* `Standard_B2s`
* `Standard_B2ms`

➡️ Prevents accidental creation of expensive VM sizes.

---

### 3️⃣ Mandatory Tagging Policy

Enforces mandatory tags on supported resources:

**Required tags:**

* `department`
* `project`

➡️ Resources missing these tags are **DENIED**.

---

## 🏗 Architecture (Terraform Perspective)

Terraform provisions and manages:

* Azure Policy Definitions (Custom)
* Azure Policy Assignments
* Subscription-level governance enforcement

**Flow:**

Terraform
→ Azure Policy Definitions
→ Subscription Policy Assignments
→ Governance enforced across subscription

---

## 🛠 Tech Stack

* **Terraform**
* **Azure Policy**
* **Azure RBAC**
* **Azure CLI**
* **Azure Entra ID (Azure AD)**

---

## 📂 Project Structure

```
azure-policy-governance-mini-project/
├── providers.tf        # Terraform & Azure provider config
├── data.tf             # Subscription data source
├── policies.tf         # Custom Azure Policy definitions
├── assignments.tf      # Subscription-level policy assignments
├── test-resources.tf   # Compliance testing using RGs
├── .gitignore
└── README.md
```

---

## 🔐 Authentication & Permissions

This project requires:

* Azure **Work/School account (Entra ID)**
* Subscription-level permissions:

  * **Owner** or
  * **Policy Contributor**

> Personal Microsoft accounts have limited governance API support.

---

## 🚀 How to Run the Project

### 1️⃣ Azure Login (recommended method)

```bash
az login --tenant <TENANT_ID> --use-device-code
```

Verify:

```bash
az account show
```

---

### 2️⃣ Initialize Terraform

```bash
terraform init
```

---

### 3️⃣ Review the Plan

```bash
terraform plan
```

---

### 4️⃣ Apply Governance Policies

```bash
terraform apply
```

---

## 🧪 Policy Enforcement Testing

Only **Resource Groups** are used for testing because:

* They are **free**
* No billing impact
* Policies apply to them

### ❌ Non-Compliant Tests (Expected to Fail)

* Resource Group in non-approved region
* Resource Group missing mandatory tags

Terraform returns:

```
RequestDisallowedByPolicy
```

---

### ✅ Compliant Test (Expected to Succeed)

```hcl
resource "azurerm_resource_group" "compliant_rg" {
  name     = "rg-compliant"
  location = "eastus"

  tags = {
    department = "devops"
    project    = "azure-governance"
  }
}
```

---

## 🔍 Verification in Azure Portal

* **Azure Portal → Policy → Definitions**
  → Verify custom policies

* **Azure Portal → Policy → Assignments**
  → Verify subscription assignments

* **Azure Portal → Policy → Compliance**
  → Review compliance status

---

## 🧠 Key Learnings

* Azure Policy Definitions require higher RBAC permissions
* `mode = "All"` is required to enforce policies on Resource Groups
* Subscription-level governance is ideal for enterprise environments
* Terraform + Azure Policy enables **Policy as Code**
* MFA and tenant-level access settings directly affect governance APIs

---

## 🧹 Cleanup (Optional)

After testing:

```bash
terraform destroy
```

This removes:

* Policy assignments
* Policy definitions
* Test resource groups

---

## ✅ Final Notes

* No paid Azure resources used
* Zero billing impact
* Enterprise-grade governance use case
* Resume & interview ready project

---

⭐ **If you like this project, feel free to fork or star the repository.**

---

