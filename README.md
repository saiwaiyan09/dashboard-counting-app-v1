# AWS Multi-Tier Infrastructure with Terraform 🚀

## 📌 Overview
This repository contains a fully automated deployment of a two-tier web application on AWS using **Terraform**. The architecture demonstrates how to securely separate a public-facing **Dashboard Service** from a private **Counting Service** using advanced networking and Infrastructure as Code (IaC) principles.

## 🛠 Tech Stack
* **Cloud Provider:** AWS (VPC, EC2, NAT Gateway, Route Tables)
* **IaC:** Terraform (Modularized Architecture)
* **OS:** Ubuntu 20.04 LTS
* **Automation:** Bash (Bootstrapping via User Data)
* **Security:** TLS/ED25519 SSH Key Management & Security Group isolation

## 🏗 Architecture Highlights
* **VPC Segmentation:** A custom VPC utilizing both **Public** and **Private** subnets to ensure high security.
* **NAT Gateway Integration:** Allows the Private Counting Service to securely fetch updates and dependencies from GitHub without being exposed to the public internet.
* **Dynamic Service Discovery:** Uses Terraform `templatefile` to inject the private IP of the Counting Service into the Dashboard's configuration at runtime.
* **Security-First Design:** Implements "Least Privilege" Security Groups, limiting internal communication to specific application ports (9002/9003).

## 📂 Project Structure
```text
├── scripts/
│   ├── dashboard-service.sh  # Bootstraps the Dashboard UI
│   └── counting-service.sh   # Bootstraps the backend API
├── vpc.tf                   # Network topology (Subnets, NAT, IGW)
├── instance.tf              # EC2 module definitions & AMI filters
├── security-groups.tf       # Firewall rules for public/private tiers
├── ssh-keys.tf              # Automated SSH key generation
├── variables.tf             # Parameterized configurations
└── outputs.tf               # Public IP and Private IP tracking