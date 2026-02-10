#!/bin/bash

# Azure Documentation Generator
# This script queries Azure and generates Markdown documentation

set -e

# Configuration
SUBSCRIPTION_NAME=$(az account show --query name -o tsv)
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
DOCS_DIR="docs"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Create docs directory if it doesn't exist
mkdir -p ${DOCS_DIR}/{resources,compute,network,storage,security}

# Generate Overview Documentation
echo "Generating overview documentation..."
cat > ${DOCS_DIR}/overview.md << EOF
# Azure Subscription Documentation

**Subscription:** ${SUBSCRIPTION_NAME}
**Subscription ID:** ${SUBSCRIPTION_ID}
**Generated:** ${TIMESTAMP}

## Quick Stats

EOF

# Count resources
RESOURCE_GROUP_COUNT=$(az group list --query "length(@)" -o tsv)
VM_COUNT=$(az vm list --query "length(@)" -o tsv)

echo "- **Resource Groups:** ${RESOURCE_GROUP_COUNT}" >> ${DOCS_DIR}/overview.md
echo "- **Virtual Machines:** ${VM_COUNT}" >> ${DOCS_DIR}/overview.md
echo "" >> ${DOCS_DIR}/overview.md

# Document Resource Groups
echo "Documenting resource groups..."
echo "## Resource Groups" >> ${DOCS_DIR}/overview.md
echo "" >> ${DOCS_DIR}/overview.md
echo "| Name | Location | Resources |" >> ${DOCS_DIR}/overview.md
echo "|------|----------|-----------|" >> ${DOCS_DIR}/overview.md

az group list --query "[].{Name:name, Location:location}" -o json | \
jq -r '.[] | "| \(.Name) | \(.Location) | - |"' >> ${DOCS_DIR}/overview.md

# Document Virtual Machines
if [ ${VM_COUNT} -gt 0 ]; then
    echo "Documenting virtual machines..."
    cat > ${DOCS_DIR}/compute/virtual-machines.md << EOF
# Azure Virtual Machines

**Generated:** ${TIMESTAMP}

## Virtual Machines List

| VM Name | Resource Group | Location | Size | OS Type | Status |
|---------|----------------|----------|------|---------|--------|
EOF

    az vm list --query "[].{Name:name, ResourceGroup:resourceGroup, Location:location, Size:hardwareProfile.vmSize, OS:storageProfile.osDisk.osType}" -o json | \
    jq -r '.[] | "| \(.Name) | \(.ResourceGroup) | \(.Location) | \(.Size) | \(.OS) | - |"' >> ${DOCS_DIR}/compute/virtual-machines.md
fi

# Document Storage Accounts
echo "Documenting storage accounts..."
STORAGE_ACCOUNTS=$(az storage account list --query "[].{Name:name, ResourceGroup:resourceGroup, Location:location, SKU:sku.name, Kind:kind}" -o json)
if [ "$(echo ${STORAGE_ACCOUNTS} | jq 'length')" -gt 0 ]; then
    cat > ${DOCS_DIR}/storage/storage-accounts.md << EOF
# Azure Storage Accounts

**Generated:** ${TIMESTAMP}

## Storage Accounts List

| Account Name | Resource Group | Location | SKU | Kind |
|--------------|----------------|----------|-----|------|
EOF

    echo "${STORAGE_ACCOUNTS}" | jq -r '.[] | "| \(.Name) | \(.ResourceGroup) | \(.Location) | \(.SKU) | \(.Kind) |"' >> ${DOCS_DIR}/storage/storage-accounts.md
fi

# Document Virtual Networks
echo "Documenting virtual networks..."
VNETS=$(az network vnet list --query "[].{Name:name, ResourceGroup:resourceGroup, Location:location, AddressSpace:addressSpace.addressPrefixes[0]}" -o json)
if [ "$(echo ${VNETS} | jq 'length')" -gt 0 ]; then
    cat > ${DOCS_DIR}/network/virtual-networks.md << EOF
# Azure Virtual Networks

**Generated:** ${TIMESTAMP}

## Virtual Networks List

| VNet Name | Resource Group | Location | Address Space |
|-----------|----------------|----------|---------------|
EOF

    echo "${VNETS}" | jq -r '.[] | "| \(.Name) | \(.ResourceGroup) | \(.Location) | \(.AddressSpace) |"' >> ${DOCS_DIR}/network/virtual-networks.md
fi

echo ""
echo "✅ Documentation generated successfully!"
echo "📁 Output directory: ${DOCS_DIR}"
echo ""
echo "Generated files:"
find ${DOCS_DIR} -type f -name "*.md" | sort
