
---

# Azure Web Apps using Terraform

### App Service • Deployment Slots • GitHub Integration (IaC Mini Project)

---

## 1. introduction

This mini project demonstrates how to provision **Azure App Service (Web App)** using **Terraform** following **Infrastructure as Code (IaC)** principles.

The focus is:

* infrastructure provisioning
* configuration management
* deployment strategy (slots & blue-green)

Application development is **out of scope**.

---

## 2. project objective

Using Terraform, we will:

* create an Azure Resource Group
* provision an App Service Plan
* create an Azure Web App
* create a deployment slot (staging)
* integrate GitHub source control
* perform blue-green deployment using slots

---

## 3. why terraform for app service?

Terraform provides:

* declarative infrastructure
* version-controlled configuration
* repeatable deployments
* drift detection
* easy destroy & recreation

Terraform acts as the **single source of truth**.

---

## 4. architecture overview (terraform view)

Terraform provisions:

* Resource Group
* App Service Plan (Standard SKU)
* Web App (production slot)
* Deployment Slot (staging)
* GitHub Source Control
* Active Slot Swap

**Flow:**

Terraform
→ Azure Resource Group
→ App Service Plan
→ Web App (Prod)
→ Slot (Staging)
→ GitHub Deployment
→ Slot Swap (Blue-Green)

---

## 5. prerequisites

* Azure subscription
* Terraform installed
* Azure login configured (`az login`)
* GitHub repository (sample app)

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
  default = "mini-project"
}
```

### why this is important

* reusable code
* environment-friendly
* avoids hardcoding
* standard Terraform practice

---

## 8. resource group provisioning

```hcl
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = "canadacentral"
}
```

**Use case**

* logical grouping of resources
* lifecycle managed by Terraform

---

## 9. app service plan provisioning

```hcl
resource "azurerm_app_service_plan" "asp" {
  name                = "${var.prefix}-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}
```

### key notes

* App Service Plan controls **cost & compute**
* `Standard S1` supports **deployment slots**
* Slots are not available in Free tier

---

## 10. web app (production slot)

```hcl
resource "azurerm_app_service" "as" {
  name                = "${var.prefix}-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}
```

### important behavior

* this is the **production slot**
* public endpoint auto-generated
* managed PaaS service

---

## 11. deployment slot (staging)

```hcl
resource "azurerm_app_service_slot" "slot" {
  name                = "${var.prefix}-staging"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  app_service_name    = azurerm_app_service.as.name
}
```

### use cases

* zero-downtime deployments
* blue-green strategy
* pre-production testing

---

## 12. github source control (production)

```hcl
resource "azurerm_app_service_source_control" "scm" {
  app_id   = azurerm_app_service.as.id
  repo_url = "https://github.com/piyushsachdeva/tf-sample-bg"
  branch   = "master"
}
```

### what this does

* enables continuous deployment
* auto-deploys on push
* no portal configuration required

---

## 13. github source control (staging slot)

```hcl
resource "azurerm_app_service_source_control_slot" "scm1" {
  slot_id  = azurerm_app_service_slot.slot.id
  repo_url = "https://github.com/piyushsachdeva/tf-sample-bg"
  branch   = "appServiceSlot_Working_DO_NOT_MERGE"
}
```

### real-world pattern

* different branches per environment
* safer deployments
* isolated testing

---

## 14. blue-green deployment using slots

| Environment | Slot    | Git Branch   |
| ----------- | ------- | ------------ |
| Production  | default | master       |
| Staging     | slot    | feature/test |

### flow

1. push code to staging branch
2. deploy to staging slot
3. validate changes
4. swap slots

---

## 15. slot swap (make staging live)

```hcl
resource "azurerm_web_app_active_slot" "active" {
  slot_id = azurerm_app_service_slot.slot.id
}
```

### effect

* staging becomes production
* zero downtime
* rollback supported

---

## 16. terraform execution flow

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Destroy everything:

```bash
terraform destroy
```

---

## 17. dependency management (terraform)

Terraform automatically manages dependencies:

1. resource group
2. app service plan
3. web app
4. slot
5. source control
6. slot activation

No manual `depends_on` required.

---

## 18. state management & drift

Terraform state tracks:

* app service
* slots
* source control
* active slot

⚠️ Avoid:

* manual Azure portal changes

Best practice:

* manage everything via Terraform

---

## 19. common issues & fixes

| Issue            | Reason            | Fix                |
| ---------------- | ----------------- | ------------------ |
| Slot not created | Wrong SKU         | Use Standard+      |
| Name conflict    | Global uniqueness | Change prefix      |
| Drift            | Portal edits      | Re-apply Terraform |

---

## 20. interview talking points (important)

* Azure App Service is PaaS
* App Service Plan defines compute & pricing
* Deployment slots enable zero downtime
* Terraform manages infra, not app code
* CI/CD handles application delivery

---

## 21. why this mini project is documented

* feature already implemented in real project
* infrastructure behavior already understood
* documentation enables quick revision

---

## 22. final summary

* Azure Web App fully provisioned via Terraform
* Deployment slots enable blue-green strategy
* GitHub integration is declarative
* Infrastructure is reproducible & scalable
* Terraform best practices followed

---


