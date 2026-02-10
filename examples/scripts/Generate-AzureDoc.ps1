# Azure Documentation Generator - PowerShell Version
# This script queries Azure and generates Markdown documentation

# Ensure Azure PowerShell module is installed
# Install-Module -Name Az -Repository PSGallery -Force

# Check if connected to Azure
try {
    $context = Get-AzContext
    if (-not $context) {
        Write-Host "Not connected to Azure. Please run Connect-AzAccount first." -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "Azure PowerShell module not found. Please install it first." -ForegroundColor Red
    Write-Host "Run: Install-Module -Name Az -Repository PSGallery -Force" -ForegroundColor Yellow
    exit 1
}

# Configuration
$subscription = Get-AzContext
$docsPath = "docs"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Create directory structure
$directories = @(
    "$docsPath",
    "$docsPath/resources",
    "$docsPath/compute",
    "$docsPath/network",
    "$docsPath/storage",
    "$docsPath/security"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
}

Write-Host "Generating Azure documentation..." -ForegroundColor Green

# Generate Overview Documentation
$overview = @"
# Azure Subscription Documentation

**Subscription:** $($subscription.Subscription.Name)
**Subscription ID:** $($subscription.Subscription.Id)
**Tenant ID:** $($subscription.Tenant.Id)
**Generated:** $timestamp

## Quick Stats

"@

# Count resources
$resourceGroups = Get-AzResourceGroup
$vms = Get-AzVM

$overview += "- **Resource Groups:** $($resourceGroups.Count)`n"
$overview += "- **Virtual Machines:** $($vms.Count)`n`n"

# Document Resource Groups
Write-Host "Documenting resource groups..." -ForegroundColor Cyan
$overview += "## Resource Groups`n`n"
$overview += "| Name | Location | Tags |`n"
$overview += "|------|----------|------|`n"

foreach ($rg in $resourceGroups) {
    $tags = if ($rg.Tags) { ($rg.Tags.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join ", " } else { "-" }
    $overview += "| $($rg.ResourceGroupName) | $($rg.Location) | $tags |`n"
}

$overview | Out-File -FilePath "$docsPath/overview.md" -Encoding UTF8

# Document Virtual Machines
if ($vms.Count -gt 0) {
    Write-Host "Documenting virtual machines..." -ForegroundColor Cyan
    $vmDoc = @"
# Azure Virtual Machines

**Generated:** $timestamp

## Virtual Machines List

| VM Name | Resource Group | Location | Size | OS Type | Status |
|---------|----------------|----------|------|---------|--------|

"@

    foreach ($vm in $vms) {
        $vmStatus = (Get-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Status).Statuses | 
                    Where-Object { $_.Code -like "PowerState/*" } | 
                    Select-Object -ExpandProperty DisplayStatus
        
        $osType = $vm.StorageProfile.OsDisk.OsType
        $vmDoc += "| $($vm.Name) | $($vm.ResourceGroupName) | $($vm.Location) | $($vm.HardwareProfile.VmSize) | $osType | $vmStatus |`n"
    }

    $vmDoc | Out-File -FilePath "$docsPath/compute/virtual-machines.md" -Encoding UTF8
}

# Document Storage Accounts
Write-Host "Documenting storage accounts..." -ForegroundColor Cyan
$storageAccounts = Get-AzStorageAccount

if ($storageAccounts.Count -gt 0) {
    $storageDoc = @"
# Azure Storage Accounts

**Generated:** $timestamp

## Storage Accounts List

| Account Name | Resource Group | Location | SKU | Kind | Access Tier |
|--------------|----------------|----------|-----|------|-------------|

"@

    foreach ($sa in $storageAccounts) {
        $tier = if ($sa.AccessTier) { $sa.AccessTier } else { "-" }
        $storageDoc += "| $($sa.StorageAccountName) | $($sa.ResourceGroupName) | $($sa.Location) | $($sa.Sku.Name) | $($sa.Kind) | $tier |`n"
    }

    $storageDoc | Out-File -FilePath "$docsPath/storage/storage-accounts.md" -Encoding UTF8
}

# Document Virtual Networks
Write-Host "Documenting virtual networks..." -ForegroundColor Cyan
$vnets = Get-AzVirtualNetwork

if ($vnets.Count -gt 0) {
    $vnetDoc = @"
# Azure Virtual Networks

**Generated:** $timestamp

## Virtual Networks List

| VNet Name | Resource Group | Location | Address Space | Subnets |
|-----------|----------------|----------|---------------|---------|

"@

    foreach ($vnet in $vnets) {
        $addressSpace = ($vnet.AddressSpace.AddressPrefixes -join ", ")
        $subnetCount = $vnet.Subnets.Count
        $vnetDoc += "| $($vnet.Name) | $($vnet.ResourceGroupName) | $($vnet.Location) | $addressSpace | $subnetCount |`n"
    }

    $vnetDoc | Out-File -FilePath "$docsPath/network/virtual-networks.md" -Encoding UTF8
}

# Document Network Security Groups
Write-Host "Documenting network security groups..." -ForegroundColor Cyan
$nsgs = Get-AzNetworkSecurityGroup

if ($nsgs.Count -gt 0) {
    $nsgDoc = @"
# Azure Network Security Groups

**Generated:** $timestamp

## Network Security Groups List

| NSG Name | Resource Group | Location | Rules Count |
|----------|----------------|----------|-------------|

"@

    foreach ($nsg in $nsgs) {
        $rulesCount = ($nsg.SecurityRules.Count + $nsg.DefaultSecurityRules.Count)
        $nsgDoc += "| $($nsg.Name) | $($nsg.ResourceGroupName) | $($nsg.Location) | $rulesCount |`n"
    }

    $nsgDoc | Out-File -FilePath "$docsPath/security/network-security-groups.md" -Encoding UTF8
}

Write-Host "`n✅ Documentation generated successfully!" -ForegroundColor Green
Write-Host "📁 Output directory: $docsPath" -ForegroundColor Yellow
Write-Host "`nGenerated files:" -ForegroundColor Yellow
Get-ChildItem -Path $docsPath -Recurse -Filter "*.md" | Select-Object -ExpandProperty FullName | Sort-Object
