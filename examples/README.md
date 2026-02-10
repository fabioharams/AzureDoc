# Examples Directory

This directory contains example scripts, templates, and sample documentation for the AzureDoc tutorial.

## Directory Structure

```
examples/
├── scripts/          # Automation scripts
├── templates/        # Documentation templates
├── docs/            # Sample generated documentation
└── requirements.txt # Python dependencies
```

## Scripts

### Bash Script: `generate-docs.sh`
- **Platform:** Linux, macOS, WSL
- **Requirements:** Azure CLI, Bash, jq
- **Usage:** `./generate-docs.sh`

Generates documentation for:
- Subscription overview
- Resource groups
- Virtual machines
- Storage accounts
- Virtual networks

### PowerShell Script: `Generate-AzureDoc.ps1`
- **Platform:** Windows, PowerShell Core (cross-platform)
- **Requirements:** Azure PowerShell module
- **Usage:** `.\Generate-AzureDoc.ps1`

Generates documentation for:
- Subscription overview
- Resource groups
- Virtual machines
- Storage accounts
- Virtual networks
- Network security groups

### Python Script: `azure_doc_generator.py`
- **Platform:** Cross-platform (Python 3.7+)
- **Requirements:** Azure SDK for Python
- **Usage:** `python azure_doc_generator.py`

Features:
- Object-oriented design
- Comprehensive error handling
- Modular functions for each resource type
- Easy to extend with new resource types

## Templates

### Resource Group Template: `resource-group-template.md`
Comprehensive template for documenting Azure resource groups including:
- Overview and configuration
- Cost analysis
- Access control (IAM)
- Tags and policies
- Network configuration
- Monitoring and alerts
- Backup and security

### VM Template: `vm-template.md`
Detailed template for documenting virtual machines including:
- Compute configuration
- Operating system details
- Networking setup
- Storage (OS and data disks)
- Availability and scalability
- Monitoring and alerts
- Security and identity
- Backup configuration
- Extensions and agents
- Cost information

## Sample Documentation

The `docs/` directory contains example documentation showing what the generated output looks like. Use these as reference when customizing your own documentation.

## Getting Started

1. **Choose Your Script:**
   - Bash: Fast, lightweight, great for Linux/Mac
   - PowerShell: Best for Windows, rich Azure PowerShell module
   - Python: Most flexible, easy to customize and extend

2. **Install Dependencies:**
   ```bash
   # For Bash script
   sudo apt-get install jq  # or brew install jq on macOS
   
   # For Python script
   pip install -r requirements.txt
   ```

3. **Login to Azure:**
   ```bash
   # Using Azure CLI
   az login
   
   # Using PowerShell
   Connect-AzAccount
   ```

4. **Run Your Chosen Script:**
   ```bash
   cd scripts/
   
   # Bash
   ./generate-docs.sh
   
   # PowerShell
   .\Generate-AzureDoc.ps1
   
   # Python
   python azure_doc_generator.py
   ```

## Customization

### Adding New Resource Types

To document additional Azure resources:

1. **Identify the Azure CLI command** (for Bash):
   ```bash
   az <resource-type> list --query "[].{Name:name, ...}" -o json
   ```

2. **Find the PowerShell cmdlet** (for PowerShell):
   ```powershell
   Get-Az<ResourceType>
   ```

3. **Use Azure SDK** (for Python):
   ```python
   from azure.mgmt.<service> import <ServiceClient>
   client = <ServiceClient>(credential, subscription_id)
   resources = client.<resource_type>.list()
   ```

### Using GitHub Copilot

Open any script in VS Code and ask Copilot to help:

**Example Prompts:**
- "Add a function to document Azure App Services with their pricing tiers"
- "Create a section for Azure SQL Databases showing tier and DTU"
- "Add error handling for rate limiting"
- "Generate a cost summary table"

## Tips

- **Start Small:** Begin with the basic scripts and gradually add more resource types
- **Use Templates:** Copy the templates and fill them in for manual documentation
- **Automate:** Set up GitHub Actions to run scripts automatically
- **Customize Output:** Modify the Markdown formatting to match your organization's style
- **Version Control:** Keep documentation in Git to track changes over time

## Troubleshooting

### Common Issues

**Script runs but generates empty files:**
- Check that you're logged in to Azure: `az account show`
- Verify you have resources in your subscription
- Check that you have proper permissions to read resources

**Permission errors:**
- Make scripts executable: `chmod +x script-name.sh`
- Check Azure RBAC permissions (Reader role minimum required)

**Module not found errors (Python):**
- Install dependencies: `pip install -r requirements.txt`
- Ensure you're using Python 3.7 or higher

**Azure CLI not authenticated:**
- Run `az login` and follow the prompts
- Set the correct subscription: `az account set --subscription "name"`

## Contributing

Found a bug or have an improvement? See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on contributing to this project.

## Resources

- [Azure CLI Documentation](https://docs.microsoft.com/cli/azure/)
- [Azure PowerShell Documentation](https://docs.microsoft.com/powershell/azure/)
- [Azure SDK for Python](https://docs.microsoft.com/python/api/overview/azure/)
- [GitHub Copilot](https://github.com/features/copilot)

---

Need help? Check the main [README.md](../README.md) or open an issue!
