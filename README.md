# Terraform-Module

A modular Terraform setup for deploying AWS infrastructure and containerized applications like **Frappe Helpdesk** and **Portshell Ticketing** using EC2, Docker, and Terraform.

---

## 📁 Project Structure

https://sdmntprcentralus.oaiusercontent.com/files/00000000-06d0-61f5-bcaf-2c6466eae563/raw?se=2025-10-12T21%3A54%3A04Z&sp=r&sv=2024-08-04&sr=b&scid=93b25d04-f993-51fc-8215-e4fd97954f85&skoid=71e8fa5c-90a9-4c17-827b-14c3005164d6&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2025-10-12T12%3A26%3A20Z&ske=2025-10-13T12%3A26%3A20Z&sks=b&skv=2024-08-04&sig=acvCMmIz8Y1Cn4vdCKOS%2B0mjQQvTuVF8e9WjqlTAsPI%3D
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