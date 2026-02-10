# AzureDoc

**Tutorial: Document Your Microsoft Azure Subscription Using Visual Studio Code and GitHub Copilot**

## 📖 Overview

This tutorial teaches you how to automatically document your Microsoft Azure subscription using Visual Studio Code (VS Code) and GitHub Copilot. You'll learn to connect to Azure, generate comprehensive Markdown documentation, leverage AI-assisted prompts, and organize your cloud resources in a version-controlled workflow.

**Ideal for:** Cloud architects, developers, cloud engineers, IT administrators, and anyone managing Azure resources who wants quick, automated documentation.

## 🎯 What You'll Learn

- Connect to Azure from VS Code
- Query Azure resources using Azure CLI
- Generate Markdown documentation automatically
- Use GitHub Copilot for AI-assisted documentation
- Organize documentation in a version-controlled repository
- Create reusable documentation templates
- Best practices for maintaining cloud documentation

## 📋 Prerequisites

Before starting this tutorial, ensure you have:

- **Azure Subscription**: An active Microsoft Azure subscription ([Get a free trial](https://azure.microsoft.com/free/))
- **Visual Studio Code**: Latest version installed ([Download VS Code](https://code.visualstudio.com/))
- **GitHub Copilot**: Active subscription and extension installed ([GitHub Copilot](https://github.com/features/copilot))
- **Azure CLI**: Version 2.0 or higher ([Install Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli))
- **Git**: For version control ([Download Git](https://git-scm.com/downloads))
- Basic knowledge of Markdown and command-line interfaces

## 🚀 Getting Started

### Step 1: Set Up Your Environment

1. **Install Required VS Code Extensions**

   Open VS Code and install these extensions:
   - **GitHub Copilot** (`GitHub.copilot`)
   - **GitHub Copilot Chat** (`GitHub.copilot-chat`)
   - **Azure Account** (`ms-vscode.azure-account`)
   - **Azure CLI Tools** (`ms-vscode.azurecli`)
   - **Markdown All in One** (`yzhang.markdown-all-in-one`)

   ```bash
   # Install extensions via command line (optional)
   code --install-extension GitHub.copilot
   code --install-extension GitHub.copilot-chat
   code --install-extension ms-vscode.azure-account
   code --install-extension ms-vscode.azurecli
   code --install-extension yzhang.markdown-all-in-one
   ```

2. **Verify Azure CLI Installation**

   ```bash
   # Check Azure CLI version
   az --version
   
   # Should show version 2.0 or higher
   ```

3. **Create a Documentation Repository**

   ```bash
   # Create a new directory for your Azure documentation
   mkdir azure-documentation
   cd azure-documentation
   
   # Initialize Git repository
   git init
   
   # Create initial structure
   mkdir -p docs/{resources,security,network,compute,storage}
   touch README.md
   ```

### Step 2: Connect to Azure

1. **Login to Azure**

   ```bash
   # Login to your Azure account
   az login
   
   # If you have multiple subscriptions, list them
   az account list --output table
   
   # Set the subscription you want to document
   az account set --subscription "Your-Subscription-Name-or-ID"
   
   # Verify the current subscription
   az account show --output table
   ```

2. **Test Your Connection**

   ```bash
   # List resource groups to verify connectivity
   az group list --output table
   ```

### Step 3: Generate Your First Documentation

#### Option A: Using Azure CLI with GitHub Copilot

1. **Create a Documentation Script**

   Create a new file `generate-docs.sh` in VS Code:

   ```bash
   #!/bin/bash
   
   # Azure Documentation Generator
   # This script queries Azure and generates Markdown documentation
   
   SUBSCRIPTION_NAME=$(az account show --query name -o tsv)
   SUBSCRIPTION_ID=$(az account show --query id -o tsv)
   DOCS_DIR="docs"
   
   echo "# Azure Subscription Documentation" > ${DOCS_DIR}/overview.md
   echo "" >> ${DOCS_DIR}/overview.md
   echo "**Subscription:** ${SUBSCRIPTION_NAME}" >> ${DOCS_DIR}/overview.md
   echo "**Subscription ID:** ${SUBSCRIPTION_ID}" >> ${DOCS_DIR}/overview.md
   echo "**Generated:** $(date)" >> ${DOCS_DIR}/overview.md
   echo "" >> ${DOCS_DIR}/overview.md
   
   # Document Resource Groups
   echo "## Resource Groups" >> ${DOCS_DIR}/overview.md
   echo "" >> ${DOCS_DIR}/overview.md
   az group list --query "[].{Name:name, Location:location, Tags:tags}" -o table >> ${DOCS_DIR}/overview.md
   
   echo "Documentation generated successfully!"
   ```

2. **Use GitHub Copilot to Enhance the Script**

   - Open `generate-docs.sh` in VS Code
   - Use Copilot Chat with prompts like:
     - "Add a function to document all VMs in the subscription"
     - "Create a section for documenting storage accounts"
     - "Add error handling to this script"
   - Copilot will suggest code completions as you type

3. **Run the Script**

   ```bash
   # Make script executable
   chmod +x generate-docs.sh
   
   # Run the script
   ./generate-docs.sh
   ```

#### Option B: Using PowerShell with Azure PowerShell

1. **Create a PowerShell Documentation Script**

   Create `Generate-AzureDoc.ps1`:

   ```powershell
   # Azure Documentation Generator - PowerShell Version
   
   # Connect to Azure (if not already connected)
   # Connect-AzAccount
   
   $subscription = Get-AzSubscription | Select-Object -First 1
   $docsPath = "docs"
   
   # Create overview document
   $doc = @"
   # Azure Subscription Documentation
   
   **Subscription:** $($subscription.Name)
   **Subscription ID:** $($subscription.Id)
   **Generated:** $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
   
   ## Resource Groups
   
   "@
   
   # Get resource groups
   $resourceGroups = Get-AzResourceGroup
   foreach ($rg in $resourceGroups) {
       $doc += "### $($rg.ResourceGroupName)`n"
       $doc += "- **Location:** $($rg.Location)`n"
       $doc += "- **Tags:** $($rg.Tags | ConvertTo-Json -Compress)`n`n"
   }
   
   # Save documentation
   $doc | Out-File -FilePath "$docsPath/overview.md"
   Write-Host "Documentation generated successfully!"
   ```

### Step 4: Advanced Documentation with GitHub Copilot

#### Using Copilot Chat for Documentation Queries

1. **Open Copilot Chat** in VS Code (Ctrl+Shift+I or Cmd+Shift+I)

2. **Try These AI-Assisted Prompts:**

   ```
   Prompt: "Create a bash script that documents all Azure VMs with their sizes, 
   OS type, and power state in a Markdown table format"
   
   Prompt: "Generate a Python script to export Azure resource tags to a JSON 
   file for documentation purposes"
   
   Prompt: "Write a function to document Azure Network Security Groups including 
   all inbound and outbound rules"
   
   Prompt: "Create documentation for Azure storage accounts showing their SKU, 
   replication type, and access tier"
   ```

3. **Example: Document Virtual Machines**

   Ask Copilot: "Create a script to document all Azure VMs"

   Copilot might generate something like:

   ```bash
   #!/bin/bash
   
   # Document Azure Virtual Machines
   OUTPUT_FILE="docs/compute/virtual-machines.md"
   
   echo "# Azure Virtual Machines" > ${OUTPUT_FILE}
   echo "" >> ${OUTPUT_FILE}
   echo "Generated: $(date)" >> ${OUTPUT_FILE}
   echo "" >> ${OUTPUT_FILE}
   
   # Get all VMs
   VMS=$(az vm list --query "[].{Name:name, ResourceGroup:resourceGroup, Location:location, Size:hardwareProfile.vmSize}" -o json)
   
   # Convert to Markdown table
   echo "| VM Name | Resource Group | Location | Size |" >> ${OUTPUT_FILE}
   echo "|---------|----------------|----------|------|" >> ${OUTPUT_FILE}
   
   echo "${VMS}" | jq -r '.[] | "| \(.Name) | \(.ResourceGroup) | \(.Location) | \(.Size) |"' >> ${OUTPUT_FILE}
   
   echo "VM documentation created at ${OUTPUT_FILE}"
   ```

### Step 5: Create Documentation Templates

Create reusable templates for consistent documentation:

1. **Resource Group Template** (`templates/resource-group.md`):

   ```markdown
   # Resource Group: [NAME]
   
   ## Overview
   - **Name:** [RESOURCE_GROUP_NAME]
   - **Location:** [LOCATION]
   - **Subscription:** [SUBSCRIPTION]
   - **Created:** [DATE]
   
   ## Tags
   [TAGS_LIST]
   
   ## Resources
   [RESOURCES_TABLE]
   
   ## Cost Analysis
   [COST_INFORMATION]
   
   ## Access Control (IAM)
   [IAM_ROLES]
   ```

2. **Virtual Machine Template** (`templates/vm.md`):

   ```markdown
   # Virtual Machine: [VM_NAME]
   
   ## Configuration
   - **Name:** [VM_NAME]
   - **Resource Group:** [RG_NAME]
   - **Size:** [VM_SIZE]
   - **OS:** [OS_TYPE]
   - **Location:** [LOCATION]
   
   ## Networking
   - **Virtual Network:** [VNET]
   - **Subnet:** [SUBNET]
   - **Private IP:** [PRIVATE_IP]
   - **Public IP:** [PUBLIC_IP]
   
   ## Disks
   [DISK_CONFIGURATION]
   
   ## Monitoring
   [MONITORING_STATUS]
   ```

### Step 6: Automate with Python (Optional)

For more complex documentation needs, use Python with Azure SDK:

1. **Install Azure SDK for Python**

   ```bash
   pip install azure-identity azure-mgmt-resource azure-mgmt-compute azure-mgmt-network
   ```

2. **Create a Python Documentation Script** (`azure_doc_generator.py`):

   ```python
   from azure.identity import DefaultAzureCredential
   from azure.mgmt.resource import ResourceManagementClient
   from azure.mgmt.compute import ComputeManagementClient
   from datetime import datetime
   import os
   
   # Authenticate
   credential = DefaultAzureCredential()
   subscription_id = os.environ.get("AZURE_SUBSCRIPTION_ID")
   
   # Initialize clients
   resource_client = ResourceManagementClient(credential, subscription_id)
   compute_client = ComputeManagementClient(credential, subscription_id)
   
   def generate_resource_groups_doc():
       """Generate documentation for all resource groups"""
       doc = "# Azure Resource Groups\n\n"
       doc += f"**Generated:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n"
       
       for rg in resource_client.resource_groups.list():
           doc += f"## {rg.name}\n"
           doc += f"- **Location:** {rg.location}\n"
           doc += f"- **Tags:** {rg.tags}\n\n"
       
       with open("docs/resources/resource-groups.md", "w") as f:
           f.write(doc)
       
       print("Resource groups documentation generated!")
   
   def generate_vms_doc():
       """Generate documentation for all virtual machines"""
       doc = "# Azure Virtual Machines\n\n"
       doc += f"**Generated:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n"
       
       for vm in compute_client.virtual_machines.list_all():
           doc += f"## {vm.name}\n"
           doc += f"- **Location:** {vm.location}\n"
           doc += f"- **VM Size:** {vm.hardware_profile.vm_size}\n"
           doc += f"- **OS Type:** {vm.storage_profile.os_disk.os_type}\n\n"
       
       with open("docs/compute/virtual-machines.md", "w") as f:
           f.write(doc)
       
       print("VM documentation generated!")
   
   if __name__ == "__main__":
       generate_resource_groups_doc()
       generate_vms_doc()
   ```

3. **Run the Python Script with Copilot's Help**

   Ask Copilot to enhance the script:
   - "Add error handling for authentication failures"
   - "Include network interface details for each VM"
   - "Add a function to document Azure SQL databases"

### Step 7: Version Control Your Documentation

1. **Create a .gitignore File**

   ```bash
   # Create .gitignore
   cat > .gitignore << EOF
   # Azure credentials
   .azure/
   *.pem
   *.key
   
   # Python
   __pycache__/
   *.py[cod]
   venv/
   .env
   
   # Logs
   *.log
   
   # OS files
   .DS_Store
   Thumbs.db
   EOF
   ```

2. **Commit Your Documentation**

   ```bash
   # Add all documentation files
   git add docs/ templates/ *.sh *.ps1 *.py README.md .gitignore
   
   # Commit with a descriptive message
   git commit -m "Initial Azure subscription documentation"
   
   # Push to GitHub (after creating a repository)
   git remote add origin https://github.com/yourusername/azure-documentation.git
   git branch -M main
   git push -u origin main
   ```

3. **Set Up Automated Documentation Updates**

   Create a GitHub Actions workflow (`.github/workflows/update-docs.yml`):

   ```yaml
   name: Update Azure Documentation
   
   on:
     schedule:
       - cron: '0 0 * * 0'  # Run weekly on Sunday at midnight
     workflow_dispatch:  # Allow manual trigger
   
   jobs:
     update-docs:
       runs-on: ubuntu-latest
       steps:
         - name: Checkout repository
           uses: actions/checkout@v3
         
         - name: Azure Login
           uses: azure/login@v1
           with:
             creds: ${{ secrets.AZURE_CREDENTIALS }}
         
         - name: Generate Documentation
           run: |
             chmod +x generate-docs.sh
             ./generate-docs.sh
         
         - name: Commit and Push
           run: |
             git config user.name "GitHub Actions"
             git config user.email "actions@github.com"
             git add docs/
             git diff --quiet && git diff --staged --quiet || git commit -m "Update Azure documentation [automated]"
             git push
   ```

## 💡 Best Practices

### Documentation Organization

- **Use consistent folder structure:**
  ```
  azure-documentation/
  ├── docs/
  │   ├── overview.md
  │   ├── resources/
  │   ├── compute/
  │   ├── network/
  │   ├── storage/
  │   ├── security/
  │   └── cost/
  ├── templates/
  ├── scripts/
  └── README.md
  ```

- **Use meaningful file names:** `virtual-machines.md`, `network-security-groups.md`
- **Include timestamps:** Always add generation date/time to documents
- **Tag resources:** Use Azure tags to categorize resources in documentation

### GitHub Copilot Tips

1. **Be Specific in Your Prompts:**
   - ❌ Bad: "Document Azure resources"
   - ✅ Good: "Create a bash script that lists all Azure VMs with their sizes, locations, and power states in a Markdown table"

2. **Iterate with Copilot:**
   - Start with basic documentation
   - Ask Copilot to add more details
   - Refine the output with follow-up prompts

3. **Use Copilot Chat for Explanations:**
   - Ask: "Explain what this Azure CLI command does"
   - Ask: "How can I improve this documentation script?"

4. **Leverage Copilot for Different Formats:**
   - JSON output for programmatic use
   - Markdown tables for readability
   - YAML for configuration files

### Security Considerations

⚠️ **Important Security Notes:**

- **Never commit credentials:** Use Azure CLI authentication or managed identities
- **Sanitize output:** Remove sensitive information like connection strings, keys, and passwords
- **Use .gitignore:** Exclude sensitive files from version control
- **Consider private repositories:** For internal documentation with sensitive information
- **Review before sharing:** Always review generated documentation before publishing

## 📚 Advanced Topics

### Custom Documentation Functions

Ask GitHub Copilot to create specialized documentation functions:

```
Prompt: "Create a function to document Azure Key Vault secrets metadata 
(not values) including their expiration dates"

Prompt: "Write a script to generate a network topology diagram in Mermaid 
format from Azure Virtual Networks"

Prompt: "Create documentation for Azure App Services showing their SKU, 
runtime stack, and custom domains"
```

### Documentation Dashboards

Use the generated Markdown files to create documentation sites with:
- **MkDocs:** `pip install mkdocs && mkdocs new azure-docs`
- **Docusaurus:** `npx create-docusaurus@latest azure-docs classic`
- **Jekyll:** For GitHub Pages integration

### Integration with Other Tools

- **Azure Cost Management:** Add cost analysis to documentation
- **Azure Monitor:** Include metrics and alerts information
- **Azure DevOps:** Link documentation to work items
- **Terraform/ARM:** Document infrastructure as code alongside resources

## 🛠️ Troubleshooting

### Common Issues

**Issue: Azure CLI not authenticated**
```bash
az login
# Follow the browser authentication flow
```

**Issue: Permission denied on scripts**
```bash
chmod +x generate-docs.sh
```

**Issue: GitHub Copilot not responding**
- Check your Copilot subscription status
- Reload VS Code window (Ctrl+Shift+P → "Reload Window")
- Check internet connectivity

**Issue: Python Azure SDK errors**
```bash
# Ensure you have the correct subscription ID
export AZURE_SUBSCRIPTION_ID="your-subscription-id"

# Or use az CLI authentication
az login
```

## 📖 Additional Resources

### Microsoft Azure Documentation
- [Azure CLI Reference](https://docs.microsoft.com/cli/azure/)
- [Azure PowerShell Documentation](https://docs.microsoft.com/powershell/azure/)
- [Azure Python SDK](https://docs.microsoft.com/python/api/overview/azure/)

### GitHub Copilot
- [GitHub Copilot Documentation](https://docs.github.com/copilot)
- [Copilot Best Practices](https://github.blog/2023-06-20-how-to-write-better-prompts-for-github-copilot/)

### Markdown Resources
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Flavored Markdown](https://github.github.com/gfm/)

## 🤝 Contributing

Feel free to contribute improvements to this tutorial:
1. Fork this repository
2. Create a feature branch
3. Submit a pull request with your enhancements

## 📝 License

This tutorial is provided as-is for educational purposes.

## 💬 Feedback

Have questions or suggestions? Please open an issue in this repository.

---

**Happy Documenting! 🚀**

*Remember: Good documentation is the foundation of well-managed cloud infrastructure.*
