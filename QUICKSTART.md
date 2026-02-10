# Quick Start Guide

Get started with Azure documentation in 5 minutes!

## Prerequisites

- Azure subscription
- Visual Studio Code with GitHub Copilot
- Azure CLI installed

## Quick Setup (Linux/macOS)

```bash
# 1. Clone this repository
git clone https://github.com/fabioharams/AzureDoc.git
cd AzureDoc

# 2. Login to Azure
az login

# 3. Set your subscription
az account set --subscription "Your-Subscription-Name"

# 4. Run the documentation script
cd examples/scripts
chmod +x generate-docs.sh
./generate-docs.sh

# 5. View your documentation
cd ../../docs
ls -la
```

## Quick Setup (Windows - PowerShell)

```powershell
# 1. Clone this repository
git clone https://github.com/fabioharams/AzureDoc.git
cd AzureDoc

# 2. Login to Azure
Connect-AzAccount

# 3. Run the documentation script
cd examples\scripts
.\Generate-AzureDoc.ps1

# 4. View your documentation
cd ..\..\docs
dir
```

## Quick Setup (Python)

```bash
# 1. Clone this repository
git clone https://github.com/fabioharams/AzureDoc.git
cd AzureDoc

# 2. Install dependencies
pip install -r examples/requirements.txt

# 3. Set your subscription ID
export AZURE_SUBSCRIPTION_ID="your-subscription-id"

# 4. Login to Azure (uses default browser authentication)
az login

# 5. Run the Python script
cd examples/scripts
python azure_doc_generator.py

# 6. View your documentation
cd ../../docs
ls -la
```

## What Gets Generated?

After running any of the scripts, you'll find documentation in the `docs/` folder:

```
docs/
├── overview.md              # Subscription overview with stats
├── compute/
│   └── virtual-machines.md  # All VMs documented
├── network/
│   └── virtual-networks.md  # All VNets documented
├── storage/
│   └── storage-accounts.md  # All storage accounts documented
└── security/
    └── network-security-groups.md  # NSG documentation
```

## Using GitHub Copilot

1. Open any of the scripts in VS Code
2. Ask Copilot to enhance them:
   - "Add a function to document Azure SQL databases"
   - "Create a cost analysis section with charts"
   - "Add error handling for API rate limits"
3. Copilot will suggest code to add these features

## Next Steps

- Read the full [README.md](../README.md) for detailed tutorial
- Customize the scripts for your needs
- Use the templates in `examples/templates/` for consistent documentation
- Set up automated documentation with GitHub Actions

## Troubleshooting

**Error: Azure CLI not found**
```bash
# Install Azure CLI
# Linux: https://docs.microsoft.com/cli/azure/install-azure-cli-linux
# macOS: brew update && brew install azure-cli
# Windows: Download from https://aka.ms/installazurecliwindows
```

**Error: Permission denied on script**
```bash
chmod +x generate-docs.sh
```

**Error: Module not found (Python)**
```bash
pip install -r examples/requirements.txt
```

## Help & Support

- Read the [full tutorial](../README.md)
- Check [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines
- Open an issue on GitHub for questions

---

Happy documenting! 🚀
