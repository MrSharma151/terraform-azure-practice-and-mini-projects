
# Terraform Import – Real-World Strategy & Safe Adoption Guide

### Importing Existing Azure Infrastructure into Terraform

---

## 1. introduction

Terraform Import is used to **bring existing (already running) infrastructure under Terraform management** without recreating resources.

This guide focuses on:

* **real-world usage of Terraform Import**
* **safe workflows for live environments**
* **Azure-specific import strategies**
* **tools used in industry for large-scale imports**

This is **not a dummy lab guide**.
The goal is to understand **when, why, and how** to use Terraform Import safely.

---

## 2. what is terraform import?

Terraform Import allows you to:

* map an existing cloud resource
* into Terraform state
* **without creating or modifying the resource**

⚠️ Terraform Import:

* **does NOT generate Terraform code**
* **only updates the state file**

Code must be written **manually** or generated via tools.

---

## 3. when terraform import makes sense (very important)

Terraform Import should be used when:

* infrastructure already exists (portal / manual / scripts)
* IaC adoption is happening **after** infra creation
* brownfield or legacy environments
* production resources cannot be recreated

Examples:

* live web applications
* existing databases
* networking already in use
* long-running production workloads

---

## 4. when terraform import should be avoided

Avoid Terraform Import when:

* practicing on dummy resources
* infra can be recreated easily
* learning Terraform basics
* experimenting without full context

👉 Importing dummy resources gives **low learning value**.

---

## 5. terraform import workflow (real-world)

### High-level flow

1. Identify existing Azure resource
2. Write matching Terraform resource block
3. Import resource into Terraform state
4. Run `terraform plan`
5. Fix drift between code & actual resource
6. Apply only when confident

---

## 6. basic terraform import syntax

```bash
terraform import <RESOURCE_TYPE>.<NAME> <RESOURCE_ID>
```

Example:

```bash
terraform import azurerm_resource_group.example /subscriptions/<sub-id>/resourceGroups/rg-demo
```

📌 After this:

* Resource exists in state
* Code still must match reality

---

## 7. example: importing an existing azure resource group

### Step 1: write terraform code

```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg-demo"
  location = "eastus"
}
```

### Step 2: import resource

```bash
terraform import azurerm_resource_group.example \
/subscriptions/<SUB_ID>/resourceGroups/rg-demo
```

### Step 3: verify

```bash
terraform plan
```

Expected:

* **No changes** (if code matches actual resource)

---

## 8. importing complex resources (real challenge)

Complex resources include:

* App Services
* SQL Databases
* AKS
* Networking (VNet, Subnets, NSGs)
* IAM & RBAC

Challenges:

* hidden defaults
* implicit settings
* auto-generated names
* dependencies across resources

👉 Manual import becomes **time-consuming and risky**.

---

## 9. importing a live website – real-world reality

A live website may include:

* resource group
* app service plan
* app service
* storage account
* database
* networking
* monitoring
* identity & access

Importing such setup manually requires:

* importing **each resource separately**
* matching all attributes
* resolving dependencies

⚠️ One mistake can cause:

* unwanted changes
* accidental deletes
* downtime

---

## 10. azexport – automated terraform code generation

### what is azexport?

AZExport is a Microsoft-supported tool that:

* exports existing Azure resources
* generates Terraform configuration
* generates import commands

### when to use azexport

* medium to large environments
* multiple interconnected resources
* faster initial Terraform adoption

---

### azexport example flow

```bash
azexport resource-group framely-dev
```

Generated:

* `.tf` files
* `terraform import` commands
* resource mappings

📌 Output still requires:

* cleanup
* refactoring
* best-practice alignment

---

## 11. terraformer – large scale import tool

### what is terraformer?

Terraformer is an open-source tool that:

* scans cloud accounts
* auto-generates Terraform code + state

Supports:

* Azure
* AWS
* GCP

---

### terraformer example (azure)

```bash
terraformer import azure \
--resources=resource_group,app_service,sql \
--subscription=<SUB_ID>
```

### pros

* very fast for large infra
* generates many resources at once

### cons

* messy code
* not production-ready
* requires heavy cleanup

---

## 12. terraform import vs azexport vs terraformer

| Tool             | Best Use Case              | Risk Level |
| ---------------- | -------------------------- | ---------- |
| terraform import | Small, controlled imports  | Low        |
| azexport         | Medium real-world projects | Medium     |
| terraformer      | Large infra discovery      | High       |

---

## 13. safe strategy for production imports (IMPORTANT)

Best practice approach:

1. Create **separate Git repo**
2. Use **local backend initially**
3. Import resources **one by one**
4. Never run `terraform apply` immediately
5. Review `terraform plan` carefully
6. Gradually refactor code
7. Move to remote backend later

---

## 14. common risks & mistakes

* importing without understanding dependencies
* running apply too early
* mismatched resource arguments
* accidental deletes
* unmanaged defaults causing drift

👉 Terraform Import requires **discipline**, not speed.

---

## 15. why real projects are better import candidates

Real environments have:

* complexity
* drift
* naming inconsistencies
* real constraints

Which is why:

* dummy import practice gives false confidence
* real projects teach caution & strategy

---

## 16. why this guide is documented only (no implementation)

* live project resources are complex
* import mistakes can break application
* value lies in understanding strategy
* real implementation should be done later:

  * carefully
  * incrementally
  * when ready

---

## 17. final summary

* Terraform Import brings existing infra under IaC
* It updates state, not code
* Best used for real environments
* Requires careful planning
* Documentation-first approach saves risk and time

---


