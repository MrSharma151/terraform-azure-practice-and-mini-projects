
---

# Azure Functions using Terraform

### Function App Setup & Configuration (IaC Mini Project)

---

## 1. introduction

This mini project demonstrates how to provision **Azure Functions** using **Terraform** following **Infrastructure as Code (IaC)** principles.

Azure Functions is a **serverless compute service** that allows running event-driven code without managing servers.

This documentation focuses on:

* Function App infrastructure provisioning
* Configuration management using Terraform
* Azure Functions from a **DevOps / IaC perspective**

Application code is **out of scope**.

---

## 2. project objective

Using Terraform, we will:

* create an Azure Resource Group
* create a Storage Account (mandatory for Functions)
* create a Service Plan (Consumption / App Service plan)
* create a Function App
* configure application settings

---

## 3. why terraform for azure functions?

Using Terraform provides:

* declarative and repeatable setup
* version-controlled configuration
* consistent environments (dev/stage/prod)
* drift detection
* easy teardown

Terraform acts as the **single source of truth**.

---

## 4. architecture overview (terraform view)

Terraform provisions:

* Resource Group
* Storage Account
* Service Plan
* Function App
* Application Settings

**Flow:**

Terraform
→ Resource Group
→ Storage Account
→ Service Plan
→ Function App
→ Event-driven execution

---

## 5. prerequisites

* Azure subscription
* Terraform installed
* Azure login configured (`az login`)
* Basic understanding of serverless concepts

---

## 6. terraform provider configuration

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

---

## 7. variables and naming strategy

```hcl
variable "prefix" {
  type    = string
  default = "funcdemo"
}
```

### why this matters

* reusable infrastructure
* avoids hardcoded names
* supports multiple environments

---

## 8. resource group provisioning

```hcl
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = "centralindia"
}
```

---

## 9. storage account (mandatory for functions)

Azure Functions **require a Storage Account** for:

* triggers
* state management
* execution metadata

```hcl
resource "azurerm_storage_account" "sa" {
  name                     = "${var.prefix}sa123"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

📌 Storage Account name must be **globally unique**.

---

## 10. service plan for function app

### option a: consumption plan (recommended)

```hcl
resource "azurerm_service_plan" "plan" {
  name                = "${var.prefix}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = "Linux"
  sku_name = "Y1"
}
```

### key notes

* pay-per-execution
* auto-scale
* no idle cost

---

## 11. function app provisioning

```hcl
resource "azurerm_linux_function_app" "func" {
  name                = "${var.prefix}-functionapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  service_plan_id     = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key

  site_config {
    application_stack {
      node_version = "18"
    }
  }
}
```

### important behavior

* serverless compute
* auto scaling
* no VM management

---

## 12. application configuration (app settings)

```hcl
resource "azurerm_linux_function_app" "func" {

  # existing config omitted

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node"
    ENVIRONMENT              = "production"
  }
}
```

### use cases

* environment variables
* secrets (via Key Vault)
* runtime configuration

---

## 13. deployment approach (terraform perspective)

Terraform **does NOT deploy function code**.

### recommended approach

* Terraform provisions Function App
* CI/CD pipeline deploys code
* clear separation of concerns

📌 Terraform = infra
📌 CI/CD = application lifecycle

---

## 14. terraform execution flow

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Cleanup:

```bash
terraform destroy
```

---

## 15. dependency handling (terraform)

Terraform automatically manages:

1. Resource Group
2. Storage Account
3. Service Plan
4. Function App

No manual dependency configuration required.

---

## 16. state & drift considerations

Terraform state tracks:

* Function App
* Service Plan
* Storage Account
* App Settings

⚠️ Avoid manual portal edits to prevent drift.

---

## 17. common issues & fixes

| Issue                | Reason        | Fix                  |
| -------------------- | ------------- | -------------------- |
| Function not running | Wrong runtime | Check worker runtime |
| Storage error        | Name conflict | Change prefix        |
| Drift                | Portal config | Re-apply Terraform   |

---

## 18. interview talking points (important)

* Azure Functions is serverless (FaaS)
* Storage Account is mandatory
* Consumption plan is cost-effective
* Terraform manages infra, not code
* Event-driven architecture

---

## 19. why this mini project is documented

* already implemented in real projects
* infrastructure behavior understood
* documentation-first saves time
* focus shifted to higher ROI projects

---

## 20. final summary

* Azure Functions provisioned using Terraform
* Fully serverless and event-driven
* Configuration managed declaratively
* Scalable and cost-efficient
* Industry-aligned DevOps approach

---


