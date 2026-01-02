
---

# Terraform Provisioners – Complete Guide (Concept + Examples + Best Practices)

---

## 1. introduction

Terraform is a **declarative infrastructure as code (IaC) tool**.
Its core responsibility is to **provision and manage infrastructure**, not to configure software.

However, Terraform provides a feature called **Provisioners** to run **imperative commands** as a last resort.

---

## 2. what are provisioners?

Provisioners allow Terraform to:

* run commands
* execute scripts
* copy files

They execute:

* **after a resource is created**
* **or just before a resource is destroyed**

Provisioners are mainly used for **one-time bootstrap or temporary tasks**.

---

## 3. why provisioners are considered a "last resort"

Terraform officially discourages provisioners because:

* ❌ not idempotent
* ❌ execution not fully tracked in state
* ❌ retry behavior is unreliable
* ❌ causes infrastructure drift
* ❌ hard to debug failures
* ❌ breaks Terraform’s declarative model

📌 **Official Terraform stance**

> *"Provisioners should be used as a last resort."*

---

## 4. when provisioners are used (rare cases)

Provisioners may be acceptable when:

* legacy systems are involved
* no API or native Terraform support exists
* quick demos or POCs
* learning or experimentation

⚠️ They should **NOT** be used in production-grade infrastructure.

---

## 5. provisioner execution lifecycle

Provisioners run:

* only **after resource creation**
* or **before resource destruction**

They do **NOT**:

* participate in Terraform dependency graph
* automatically re-run on configuration changes

---

## 6. types of provisioners in terraform

Terraform supports **three main provisioners**.

---

### 6.1 local-exec provisioner

Runs commands on the **machine where Terraform is executed**.

#### common use cases

* running shell scripts
* generating local files
* sending notifications
* logging outputs

#### example

```hcl
resource "null_resource" "local_exec_example" {

  provisioner "local-exec" {
    command = "echo Terraform resource created successfully > status.txt"
  }
}
```

📌 Runs on:

* your laptop
* CI/CD runner
  ❌ **NOT inside the VM**

---

### 6.2 remote-exec provisioner

Runs commands **inside a remote resource** using:

* SSH (Linux)
* WinRM (Windows)

#### common use cases

* install packages
* configure services
* bootstrap applications

#### example

```hcl
resource "null_resource" "remote_exec_example" {

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  connection {
    type        = "ssh"
    user        = "azureuser"
    private_key = file("~/.ssh/id_rsa")
    host        = "PUBLIC_IP_OF_VM"
  }
}
```

📌 Requirements:

* VM must be reachable
* SSH/WinRM access
* correct credentials

---

### 6.3 file provisioner

Copies files from **local system to a remote resource**.

#### common use cases

* upload configuration files
* upload scripts
* copy certificates

#### example

```hcl
resource "null_resource" "file_example" {

  provisioner "file" {
    source      = "nginx.conf"
    destination = "/tmp/nginx.conf"
  }

  connection {
    type        = "ssh"
    user        = "azureuser"
    private_key = file("~/.ssh/id_rsa")
    host        = "PUBLIC_IP_OF_VM"
  }
}
```

---

## 7. destroy-time provisioners

Provisioners can also run **before resource destruction**.

#### example

```hcl
resource "null_resource" "destroy_time_example" {

  provisioner "local-exec" {
    when    = destroy
    command = "echo Resource is about to be destroyed"
  }
}
```

⚠️ **Warning**

* If a destroy-time provisioner fails, resource deletion may stop.

---

## 8. null_resource and provisioners

Provisioners must be attached to a resource.
When no real infrastructure is required, `null_resource` is used.

#### example

```hcl
resource "null_resource" "only_provisioner" {

  provisioner "local-exec" {
    command = "echo Running standalone provisioner"
  }
}
```

📌 Common use cases:

* scripting
* automation glue logic
* experiments

---

## 9. failure behavior

If a provisioner fails:

* Terraform marks the resource as failed
* partial infrastructure may exist
* no automatic rollback
* manual cleanup may be required

This makes provisioners **unsafe for production environments**.

---

## 10. best practices 

* Avoid provisioners whenever possible
* Never use provisioners for configuration management
* Keep Terraform declarative
* Use provisioners only for:

  * demos
  * learning
  * unavoidable legacy scenarios

---

## 11. recommended alternatives (industry standard)

| Requirement                 | Best Tool       |
| --------------------------- | --------------- |
| Infrastructure provisioning | Terraform       |
| VM bootstrap                | cloud-init      |
| OS & package configuration  | Ansible         |
| Image baking                | Packer          |
| Application deployment      | CI/CD pipelines |

---




