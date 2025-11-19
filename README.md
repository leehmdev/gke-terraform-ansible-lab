
# GKE Infrastructure Lab  
Provisioning a Google Kubernetes Engine cluster with **Terraform** and deploying a sample application using **Ansible** on WSL.

This project demonstrates a complete Infrastructure-as-Code workflow for Google Cloud:
- Terraform for provisioning the network + GKE cluster  
- gcloud & kubectl (Windows) for cluster authentication  
- Ansible (WSL-Ubuntu) for Kubernetes application deployment  

The lab simulates a realistic production-style workflow suitable for SRE / Cloud Engineer portfolios.

---

## 🚀 Architecture Overview

**Windows PowerShell**
- Terraform  
- gcloud  
- kubectl  

**WSL (Ubuntu)**
- Ansible  
- kubernetes.core collection  
- python3-kubernetes  

**Google Cloud Resources**
- VPC  
- Subnet  
- GKE Regional Cluster  
- Node Pool  
- Nginx Deployment with LoadBalancer Service  

---

## 🧰 Tools Used

| Tool | Purpose |
|------|---------|
| Terraform | Provision GCP infrastructure |
| gcloud | Authenticate & configure GKE |
| kubectl | Interact with Kubernetes cluster |
| Ansible | Deploy applications into GKE |
| WSL (Ubuntu) | Linux-based controller environment |

---

## 📁 Repository Structure

```
GKE-LAB/
  ├── terraform/
  │   ├── providers.tf
  │   ├── variables.tf
  │   ├── main.tf
  │   ├── outputs.tf
  ├── ansible/
  │   ├── deploy_app.yml
  │   ├── inventory.ini
  ├── README.md
  └── .gitignore
```

> **Important:**  
> - `terraform-key.json` is *not included* for security reasons.  
> - Make sure to generate and store your own GCP service account key privately.

---

## 🏗️ 1. Deploy GCP Infrastructure (Terraform)

From **Windows PowerShell**:

```powershell
cd C:\Project\GKE-LAB\terraform

terraform init
terraform plan -var="project_id=$(gcloud config get-value project)"
terraform apply -var="project_id=$(gcloud config get-value project)"
```

This provisions:

- Custom VPC  
- Subnet  
- GKE Cluster  
- Node Pool  

---

## 🔐 2. Connect kubectl to the GKE Cluster

```powershell
gcloud container clusters get-credentials demo-gke-cluster `
  --region asia-northeast1 `
  --project $(gcloud config get-value project)
```

Verify connection:

```powershell
kubectl get nodes
```

---

## 📦 3. Deploy Application with Ansible (via WSL)

From **WSL Ubuntu**:

```bash
cd /mnt/c/Project/GKE-LAB/ansible
ansible-playbook -i inventory.ini deploy_app.yml
```

Verify:

```bash
kubectl get all -n demo-app
```

Expected output:

- Nginx deployment  
- 2 running pods  
- LoadBalancer service with external IP  

---

## 🌐 4. Access the Application

Once the LoadBalancer receives an external IP:

```
http://<EXTERNAL-IP>
```

This should display the default **Nginx welcome page**.

---

## 🧹 Cleanup (Important to avoid costs)

```powershell
cd C:\Project\GKE-LAB\terraform
terraform destroy -var="project_id=$(gcloud config get-value project)"
```

This removes all GCP resources created by the lab.

---

## 📘 What you can Learned

- Designing and provisioning infrastructure using Terraform  
- Managing IAM, VPC networking, and GKE resources  
- Authenticating and interacting with Kubernetes clusters  
- Using Ansible to deploy workloads to Kubernetes clusters  
- Handling WSL(Windows) ↔ Linux hybrid workflow  
- Debugging real-world issues (IAM, quotas, environment paths, Python libs)  

---

## 🏁 Summary

This lab demonstrates practical experience with:

- **Infrastructure-as-Code (Terraform)**  
- **Kubernetes (GKE)**  
- **Configuration Management (Ansible)**  
- **Hybrid development setups (Windows + WSL)**  
- **Cloud automation & deployment workflows**

A solid foundation for SRE / DevOps / Cloud Engineer roles.

---

# 📄 License


This project is intended for educational and portfolio use.
