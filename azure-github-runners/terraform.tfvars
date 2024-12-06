# GitHub Configuration
github_repo_url = "https://github.com/your/repo"
github_token    = "your-token"

# VM Configuration
runner_count   = 4
vm_size        = "Standard_DS1_v2"
admin_username = "azureuser"

# Network Configuration
vnet_address_space = ["10.0.0.0/16"]
subnet_prefix      = ["10.0.1.0/24"]

# Region
location = "eastus"

# Environment
environment  = "dev"
project_name = "github-runners"