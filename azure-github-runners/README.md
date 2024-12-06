# Azure GitHub Actions Self-Hosted Runners

## Description
This project automates the deployment of GitHub Actions self-hosted runners in Azure. It creates a complete infrastructure where:

1. A Virtual Network isolates the runner VMs
2. Each VM automatically installs and configures the GitHub runner software
3. Storage account manages runner scripts and configurations
4. Runner VMs register themselves with your GitHub repository

### Workflow

1. Terraform creates base infrastructure (VNet, Subnet, NSG)
2. Storage account is provisioned to host runner scripts
3. VMs are deployed with custom script extension
4. Each VM downloads and installs GitHub runner
5. Runners auto-register with your repository

## Prerequisites

Required software and accounts:
- Azure CLI (>= 2.40.0)
- Terraform (>= 1.0.0)
- Packer (>= 1.8.0)
- GitHub Personal Access Token
- SSH key pair
- Visual Studio Code (recommended)

## Installation

### Clone Repository
```bash
git clone <repository-url>
cd azure-github-runners


Configure Azure

az login
az account set --subscription="SUBSCRIPTION_ID"

Configure Variables
project_name    = "github-runners"
environment     = "dev"
location        = "eastus"
runner_count    = 4
vm_size         = "Standard_DS1_v2"
github_token    = "your-github-pat"
github_repo_url = "https://github.com/your/repo"
admin_username  = "azureuser"


Deploy Infrastructure
terraform init
terraform plan
terraform apply


Project Structure
azure-github-runners/
├── modules/
│   ├── compute/      # VM and runner configuration
│   ├── network/      # VNet and subnet resources
│   └── storage/      # Storage account and scripts
├── scripts/
│   ├── configure-runner.sh
│   └── packer/
│       ├── ubuntu.pkr.hcl
│       └── scripts/
│           └── setup.sh
└── terraform/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf


Infrastructure Components:

Network Resources:
  1.Virtual Network (10.0.0.0/16)
  2.Subnet (10.0.1.0/24)
  3.Network Security Groups
  4.Network Interfaces


Compute Resources:
    1. 4 Ubuntu 18.04 LTS VMs
    2. Standard_DS1_v2 size
    3. Managed OS disks
    4. SSH key authentication
    5. Custom script extension

Storage Resources:
    1. Storage Account (Standard LRS)
    2. Private Blob Container
    3. Runner Configuration Scripts

## Variables

| Variable | Description | Type | Required | Default |
|----------|-------------|------|----------|---------|
| `project_name` | Name prefix for resources | string | yes | - |
| `environment` | Environment (dev/prod) | string | yes | "dev" |
| `location` | Azure region | string | yes | "eastus" |
| `runner_count` | Number of runner VMs | number | no | 4 |
| `vm_size` | Azure VM size | string | no | "Standard_DS1_v2" |
| `vnet_address_space` | VNet address space | list(string) | no | ["10.0.0.0/16"] |
| `subnet_prefix` | Subnet address prefix | list(string) | no | ["10.0.1.0/24"] |
| `admin_username` | VM admin username | string | yes | - |
| `github_token` | GitHub PAT for runner | string | yes | - |
| `github_repo_url` | GitHub repository URL | string | yes | - |

## Outputs

| Output | Description |
|--------|-------------|
| `runner_vm_ids` | List of created VM IDs |
| `runner_ips` | Private IPs of runner VMs |
| `storage_account_name` | Name of created storage account |
| `subnet_id` | ID of created subnet |
| `resource_group_name` | Name of resource group |


- **Network Layer**:
  - VNet provides network isolation
  - Subnet segments runner VMs
  - NSG controls inbound/outbound traffic

- **Storage Layer**:
  - Stores runner installation scripts
  - Manages VM configuration files
  - Provides blob storage for artifacts

- **Compute Layer**:
  - VMs run in private subnet
  - Custom script extension configures runners
  - Managed disks for VM storage
  - Auto-registers with GitHub