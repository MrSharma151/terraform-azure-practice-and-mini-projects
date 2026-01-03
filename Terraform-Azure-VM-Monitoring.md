
# Azure Virtual Machine Monitoring using Terraform

### Logs, Metrics, Alerts & Observability (IaC Perspective)

---

## 1. introduction

This document explains how to **set up Azure Monitoring for Virtual Machines using Terraform** following **Infrastructure as Code (IaC)** principles.

The focus of this guide is:

* observability design
* monitoring architecture
* Terraform-managed configuration
* production-ready monitoring approach

VM creation is **out of scope**.
This guide assumes the VM already exists.

---

## 2. why monitoring is critical for vms

Monitoring is essential to:

* detect performance bottlenecks
* identify failures early
* reduce downtime
* optimize costs
* ensure SLA compliance

In real environments, **monitoring is mandatory**, not optional.

---

## 3. terraform perspective on monitoring

Terraform is used to:

* enable monitoring services
* attach monitoring agents
* configure logs & metrics
* define alerting rules

Terraform **does not monitor** directly —
it **configures Azure Monitor resources**.

---

## 4. architecture overview (terraform view)

Terraform provisions and configures:

* Log Analytics Workspace
* Azure Monitor Agent (AMA)
* Diagnostic Settings
* Metric Alerts
* Action Groups

**Flow:**

VM
→ Azure Monitor Agent
→ Log Analytics Workspace
→ Metrics & Logs
→ Alerts & Notifications

---

## 5. prerequisites

* Existing Azure VM
* Azure subscription
* Terraform installed
* Azure CLI authenticated
* Basic understanding of monitoring concepts

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

## 7. log analytics workspace provisioning

Log Analytics Workspace is the **central log store**.

```hcl
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-vm-monitoring"
  location            = "eastus"
  resource_group_name = "rg-monitoring"
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
```

### purpose

* store VM logs
* store performance metrics
* query data using KQL

---

## 8. enable azure monitor agent (ama)

Azure Monitor Agent is required for:

* VM insights
* log collection
* performance counters

```hcl
resource "azurerm_virtual_machine_extension" "ama" {
  name                 = "AzureMonitorAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"
}
```

📌 Older **Log Analytics Agent is deprecated**.

---

## 9. diagnostic settings for vm logs

Diagnostic settings send logs & metrics to Log Analytics.

```hcl
resource "azurerm_monitor_diagnostic_setting" "vm_diagnostics" {
  name                       = "vm-diagnostics"
  target_resource_id         = azurerm_linux_virtual_machine.vm.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
```

### collected data

* CPU utilization
* memory
* disk IO
* network metrics

---

## 10. metric alerts (proactive monitoring)

Metric alerts help detect issues early.

### example: high cpu alert

```hcl
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "vm-high-cpu-alert"
  resource_group_name = "rg-monitoring"
  scopes              = [azurerm_linux_virtual_machine.vm.id]
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.ops_ag.id
  }
}
```

---

## 11. action groups (notifications)

Action Groups define **who gets notified**.

```hcl
resource "azurerm_monitor_action_group" "ops_ag" {
  name                = "ops-team-alerts"
  resource_group_name = "rg-monitoring"
  short_name          = "ops"

  email_receiver {
    name          = "oncall"
    email_address = "ops-team@example.com"
  }
}
```

---

## 12. monitoring data access

Monitoring data can be viewed via:

* Azure Portal → Monitor
* Log Analytics (KQL queries)
* Dashboards & Workbooks
* Alerts & Notifications

---

## 13. terraform execution flow

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

## 14. state & drift considerations

Terraform state tracks:

* workspace ID
* agent configuration
* alerts & thresholds

Avoid:

* manual portal changes
* deleting monitoring resources outside Terraform

---

## 15. security & cost considerations

* Limit log retention
* Monitor ingestion costs
* Apply RBAC to Log Analytics
* Avoid over-alerting
* Tune thresholds carefully

---

## 16. common issues & fixes

| Issue            | Cause          | Fix                |
| ---------------- | -------------- | ------------------ |
| No logs          | Agent missing  | Install AMA        |
| Alert not firing | Wrong metric   | Verify namespace   |
| High cost        | Long retention | Reduce days        |
| Drift            | Portal edits   | Re-apply Terraform |

---

## 17. why this project is documented only

* VM monitoring already implemented in real projects
* Configuration steps are repeatable
* Focus shifted to governance & CI/CD
* Documentation preserves design knowledge

---

## 18. final summary

* Azure VM monitoring fully configured using Terraform
* Logs, metrics, and alerts centralized
* Proactive monitoring implemented
* Cost-aware and secure design
* Enterprise-ready observability model

---
