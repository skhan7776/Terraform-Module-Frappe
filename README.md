# Terraform-Module

A modular Terraform setup for deploying AWS infrastructure and containerized applications like **Frappe Helpdesk** and **Portshell Ticketing** using EC2, Docker, and Terraform.

---

## 📁 Project Structure

![alt text](image.png)
└── .gitignore


---

## 🚀 Usage

### 

1️⃣ Initialize Terraform
```bash
terraform init

2️⃣ Plan your infrastructure
terraform plan

3️⃣ Deploy the stack
terraform apply -auto-approve

4️⃣ Destroy the stack
terraform destroy -auto-approve

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

⚙️ Requirements

 ->Terraform ≥ 1.5
 ->AWS CLI configured (aws configure)
 ->Docker and Docker Compose (for app services)
 ->Valid AWS credentials

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


---

### 🪄 Step 2: Add and push to GitHub

Run these commands in PowerShell from your project directory:

```powershell
git add README.md
git commit -m "Added detailed README documentation"
git push origin main

---