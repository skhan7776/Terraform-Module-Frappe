# 🧩 Terraform-Based AWS EC2 Deployment for Frappe Helpdesk

This project automates the provisioning of AWS infrastructure and deployment of a containerized **Frappe Helpdesk** application using **Terraform**, **EC2**, **Docker**, and **Docker Compose**.

---

## 📘 Overview

The project follows an **Infrastructure as Code (IaC)** approach using Terraform to:
- Create a **VPC**, **subnets**, and **security groups**
- Launch an **EC2 instance**
- Automatically run an `init.sh` script that sets up Docker, Docker Compose, and deploys the Helpdesk stack (`docker-compose.yml`)

---

**Flow Summary:**
1. Terraform provisions a VPC, subnet, and EC2 instance.
2. EC2 user data executes `init.sh`.
3. The script installs Docker and Docker Compose.
4. The Helpdesk application stack (Frappe + MariaDB + Redis) is launched.
5. Access the app via `http://<ec2-public-ip>:8000`.

---

## 📁 Project Structure

Terraform-Module/
├── .gitignore
├── instancestate.sh
├── modules/
│ ├── EC2/
│ │ ├── EC2.tf
│ │ └── variables.tf
│ └── VPC/
│ ├── VPC.tf
│ ├── output.tf
│ ├── provider.tf
│ └── variables.tf
├── services/
│ ├── portshell-ticketing/
│ │ ├── docker-compose.yml
│ │ ├── init.sh
│ │ └── main.tf
│ └── sameer-ec2/
│ ├── docker-compose.yml
│ ├── init.sh
│ └── main.tf
---

## ⚙️ Prerequisites

- AWS account with access keys configured (`aws configure`)
- Terraform v1.5+ installed
- Git installed
- SSH key pair available in AWS EC2 Console

---

## 🚀 Deployment Steps

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/skhan7776/Terraform-Module.git
cd Terraform-Module

---

1️⃣ Initialize Terraform
terraform init

2️⃣ Plan your infrastructure
terraform plan

3️⃣ Deploy the stack
terraform apply -auto-approve

4️⃣ Destroy the stack
terraform destroy -auto-approve

5️⃣ Access the Helpdesk App
Once the deployment is complete, open your browser:

http://<EC2-Public-IP>:8000

---

🧩 Modules Overview

VPC Module

Creates:
 ->A custom VPC
 ->Subnets
 ->Internet Gateway and Route Table
 ->Outputs VPC and subnet IDs

EC2 Module

Deploys:
 ->EC2 instances with key pairs
 ->Security groups
 ->User data for automatic Docker setup

---

🐳 Services
Sameer EC2

Containerized Frappe Helpdesk app.
 ->Uses docker-compose.yml and init.sh to set up MariaDB, Redis, and Frappe containers.

Portshell Ticketing
Containerized Ticketing Application using Terraform-managed EC2.

---

🧠 Notes

 ->.terraform/, .tfstate, and provider binaries are excluded in .gitignore.
 ->Always keep secrets and keys out of version control.
 ->You can modify variables.tf in modules to change instance size, subnet IDs, or region.

---

🧾 License
MIT License © 2025 Sameer Ahmed Khan
You are free to use and modify this project.

---

### 🪄 Step 2: Add and push to GitHub

Run these commands in PowerShell from your project directory:

```powershell
git add README.md
git commit -m "Added detailed README documentation"
git push origin main

---