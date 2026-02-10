"""
Azure Documentation Generator - Python Version
This script uses Azure SDK for Python to generate comprehensive documentation
"""

import os
import json
from datetime import datetime
from pathlib import Path

try:
    from azure.identity import DefaultAzureCredential
    from azure.mgmt.resource import ResourceManagementClient
    from azure.mgmt.compute import ComputeManagementClient
    from azure.mgmt.network import NetworkManagementClient
    from azure.mgmt.storage import StorageManagementClient
except ImportError:
    print("❌ Azure SDK not installed. Please install required packages:")
    print("pip install azure-identity azure-mgmt-resource azure-mgmt-compute azure-mgmt-network azure-mgmt-storage")
    exit(1)


class AzureDocGenerator:
    """Azure Documentation Generator"""
    
    def __init__(self, subscription_id=None):
        """Initialize Azure clients"""
        self.subscription_id = subscription_id or os.environ.get("AZURE_SUBSCRIPTION_ID")
        
        if not self.subscription_id:
            raise ValueError("Please set AZURE_SUBSCRIPTION_ID environment variable")
        
        # Authenticate
        self.credential = DefaultAzureCredential()
        
        # Initialize clients
        self.resource_client = ResourceManagementClient(self.credential, self.subscription_id)
        self.compute_client = ComputeManagementClient(self.credential, self.subscription_id)
        self.network_client = NetworkManagementClient(self.credential, self.subscription_id)
        self.storage_client = StorageManagementClient(self.credential, self.subscription_id)
        
        # Create docs directory structure
        self.docs_dir = Path("docs")
        self.docs_dir.mkdir(exist_ok=True)
        for subdir in ["resources", "compute", "network", "storage", "security"]:
            (self.docs_dir / subdir).mkdir(exist_ok=True)
    
    def generate_overview(self):
        """Generate overview documentation"""
        print("📝 Generating overview documentation...")
        
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        # Count resources
        resource_groups = list(self.resource_client.resource_groups.list())
        vms = list(self.compute_client.virtual_machines.list_all())
        
        doc = f"""# Azure Subscription Documentation

**Subscription ID:** {self.subscription_id}
**Generated:** {timestamp}

## Quick Stats

- **Resource Groups:** {len(resource_groups)}
- **Virtual Machines:** {len(vms)}

## Resource Groups

| Name | Location | Tags |
|------|----------|------|
"""
        
        for rg in resource_groups:
            tags = json.dumps(rg.tags) if rg.tags else "-"
            doc += f"| {rg.name} | {rg.location} | {tags} |\n"
        
        output_file = self.docs_dir / "overview.md"
        output_file.write_text(doc)
        print(f"✅ Created: {output_file}")
    
    def generate_vms_doc(self):
        """Generate documentation for all virtual machines"""
        print("📝 Generating virtual machines documentation...")
        
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        doc = f"""# Azure Virtual Machines

**Generated:** {timestamp}

## Virtual Machines List

| VM Name | Resource Group | Location | Size | OS Type | Provisioning State |
|---------|----------------|----------|------|---------|-------------------|
"""
        
        vms = list(self.compute_client.virtual_machines.list_all())
        
        if not vms:
            doc += "\n*No virtual machines found in this subscription.*\n"
        else:
            for vm in vms:
                # Parse resource group from VM ID
                rg_name = vm.id.split('/')[4]
                os_type = vm.storage_profile.os_disk.os_type if vm.storage_profile.os_disk else "Unknown"
                doc += f"| {vm.name} | {rg_name} | {vm.location} | {vm.hardware_profile.vm_size} | {os_type} | {vm.provisioning_state} |\n"
        
        output_file = self.docs_dir / "compute" / "virtual-machines.md"
        output_file.write_text(doc)
        print(f"✅ Created: {output_file}")
    
    def generate_storage_doc(self):
        """Generate documentation for storage accounts"""
        print("📝 Generating storage accounts documentation...")
        
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        doc = f"""# Azure Storage Accounts

**Generated:** {timestamp}

## Storage Accounts List

| Account Name | Resource Group | Location | SKU | Kind | Access Tier |
|--------------|----------------|----------|-----|------|-------------|
"""
        
        storage_accounts = list(self.storage_client.storage_accounts.list())
        
        if not storage_accounts:
            doc += "\n*No storage accounts found in this subscription.*\n"
        else:
            for sa in storage_accounts:
                # Parse resource group from storage account ID
                rg_name = sa.id.split('/')[4]
                access_tier = sa.access_tier if hasattr(sa, 'access_tier') and sa.access_tier else "-"
                doc += f"| {sa.name} | {rg_name} | {sa.location} | {sa.sku.name} | {sa.kind} | {access_tier} |\n"
        
        output_file = self.docs_dir / "storage" / "storage-accounts.md"
        output_file.write_text(doc)
        print(f"✅ Created: {output_file}")
    
    def generate_network_doc(self):
        """Generate documentation for virtual networks"""
        print("📝 Generating virtual networks documentation...")
        
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        doc = f"""# Azure Virtual Networks

**Generated:** {timestamp}

## Virtual Networks List

| VNet Name | Resource Group | Location | Address Space | Subnets |
|-----------|----------------|----------|---------------|---------|
"""
        
        vnets = list(self.network_client.virtual_networks.list_all())
        
        if not vnets:
            doc += "\n*No virtual networks found in this subscription.*\n"
        else:
            for vnet in vnets:
                # Parse resource group from VNet ID
                rg_name = vnet.id.split('/')[4]
                address_space = ", ".join(vnet.address_space.address_prefixes) if vnet.address_space else "-"
                subnet_count = len(vnet.subnets) if vnet.subnets else 0
                doc += f"| {vnet.name} | {rg_name} | {vnet.location} | {address_space} | {subnet_count} |\n"
        
        output_file = self.docs_dir / "network" / "virtual-networks.md"
        output_file.write_text(doc)
        print(f"✅ Created: {output_file}")
    
    def generate_all(self):
        """Generate all documentation"""
        print("🚀 Starting Azure documentation generation...\n")
        
        try:
            self.generate_overview()
            self.generate_vms_doc()
            self.generate_storage_doc()
            self.generate_network_doc()
            
            print("\n✅ Documentation generated successfully!")
            print(f"📁 Output directory: {self.docs_dir}")
            
            # List all generated files
            print("\nGenerated files:")
            for md_file in sorted(self.docs_dir.rglob("*.md")):
                print(f"  - {md_file}")
        
        except Exception as e:
            print(f"❌ Error generating documentation: {e}")
            raise


def main():
    """Main entry point"""
    # Get subscription ID from environment or command line
    subscription_id = os.environ.get("AZURE_SUBSCRIPTION_ID")
    
    if not subscription_id:
        print("❌ Error: AZURE_SUBSCRIPTION_ID environment variable not set")
        print("\nPlease set it using one of these methods:")
        print("  export AZURE_SUBSCRIPTION_ID='your-subscription-id'")
        print("  OR")
        print("  Run: az account show --query id -o tsv")
        return 1
    
    try:
        generator = AzureDocGenerator(subscription_id)
        generator.generate_all()
        return 0
    except Exception as e:
        print(f"❌ Failed to generate documentation: {e}")
        return 1


if __name__ == "__main__":
    exit(main())
