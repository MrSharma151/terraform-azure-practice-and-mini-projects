
# Azure SQL Database Provisioning using Terraform

### Infrastructure as Code (IaC) – Design, Configuration & Best Practices

---

## 1. introduction

This document explains how to **provision Azure SQL Database using Terraform** following **Infrastructure as Code (IaC)** principles.

The focus of this guide is:

* infrastructure provisioning
* configuration and security
* Terraform resource relationships
* production-ready approach

Application-level database usage is **out of scope**.

---

## 2. why terraform for azure sql?

Using Terraform for Azure SQL provides:

* declarative infrastructure
* version-controlled database configuration
* consistent environments (dev / stage / prod)
* easy recreation and teardown
* reduced manual errors

Terraform acts as the **single source of truth** for database infrastructure.

---

## 3. architecture overview (terraform view)

Terraform provisions the following Azure resources:

* Resource Group
* Azure SQL Server
* Azure SQL Database
* Firewall Rules
* Optional: Azure AD Administrator

**Flow:**

Terraform
→ Resource Group
→ Azure SQL Server
→ Azure SQL Database
→ Secure access configuration

---

## 4. prerequisites

Before provisioning Azure SQL using Terraform:

* Azure subscription
* Terraform installed
* Azure CLI authenticated
* Basic understanding of SQL & networking

---

## 5. terraform provider configuration

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

## 6. resource group provisioning

```hcl
resource "azurerm_resource_group" "rg" {
  name     = "rg-sql-terraform"
  location = "eastus"
}
```

**Purpose**

* Logical grouping
* Lifecycle managed by Terraform

---

## 7. azure sql server provisioning

Azure SQL Server is a **logical container** for databases.

```hcl
resource "azurerm_mssql_server" "sql_server" {
  name                         = "tf-sql-server-demo123"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "StrongPassword@123"
}
```

### key notes

* Server name must be **globally unique**
* Credentials should ideally come from:

  * Terraform variables
  * Azure Key Vault (recommended)

---

## 8. azure sql database provisioning

```hcl
resource "azurerm_mssql_database" "sql_db" {
  name      = "appdb"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name = "Basic"

  max_size_gb = 2
}
```

### common sku options

| SKU              | Use case               |
| ---------------- | ---------------------- |
| Basic            | Learning / low traffic |
| GeneralPurpose   | Production workloads   |
| BusinessCritical | High availability      |

---

## 9. firewall rule configuration

By default, Azure SQL is **not accessible** externally.

```hcl
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
```

### use cases

* Allow access from Azure services
* Restrict by IP in production

---

## 10. optional: azure ad authentication (recommended)

Instead of SQL authentication, **Azure AD auth** is preferred.

```hcl
resource "azurerm_mssql_active_directory_administrator" "aad_admin" {
  server_id = azurerm_mssql_server.sql_server.id
  login     = "AzureADAdmin"
  tenant_id = "<TENANT_ID>"
  object_id = "<AAD_OBJECT_ID>"
}
```

### benefits

* Centralized identity management
* Better security
* No password rotation issues

---

## 11. terraform execution flow

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Destroy resources:

```bash
terraform destroy
```

---

## 12. state management considerations

Terraform state tracks:

* SQL Server ID
* Database ID
* Firewall rules
* Authentication settings

Best practices:

* Use remote backend for teams
* Avoid manual portal changes
* Treat state as sensitive data

---

## 13. security best practices

* Store credentials in Key Vault
* Restrict firewall rules
* Enable Azure Defender for SQL
* Use Azure AD authentication
* Enable auditing & threat detection

---

## 14. common issues & fixes

| Issue         | Cause             | Fix                 |
| ------------- | ----------------- | ------------------- |
| Name conflict | Global uniqueness | Change server name  |
| Login failure | Weak password     | Use strong password |
| Access denied | Firewall blocked  | Add IP rule         |
| Drift         | Portal changes    | Re-apply Terraform  |

---

## 15. why this project is documented only

* Azure SQL provisioning already implemented in real projects
* Steps are repeatable and standardized
* Documentation captures production approach
* Time optimized for advanced DevOps work

---

## 16. final summary

* Azure SQL Database fully provisioned using Terraform
* Infrastructure remains declarative & reproducible
* Security and access controlled via IaC
* Documentation-first approach saves time
* Enterprise-aligned design

---


