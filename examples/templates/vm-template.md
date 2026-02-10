# Virtual Machine: [VM_NAME]

## Overview

- **Name:** [VM_NAME]
- **Resource Group:** [RESOURCE_GROUP_NAME]
- **Subscription:** [SUBSCRIPTION_NAME]
- **Location:** [LOCATION/REGION]
- **VM ID:** [VIRTUAL_MACHINE_ID]
- **Provisioning State:** [STATE]

## Configuration

### Compute
- **Size:** [VM_SIZE] (e.g., Standard_D2s_v3)
- **vCPUs:** [NUMBER_OF_VCPUS]
- **Memory:** [MEMORY_GB] GB
- **Generation:** [Gen1/Gen2]

### Operating System
- **OS Type:** [Windows/Linux]
- **OS:** [OS_NAME_AND_VERSION]
- **Computer Name:** [COMPUTER_NAME]
- **License Type:** [LICENSE_TYPE]

### Image
- **Publisher:** [PUBLISHER]
- **Offer:** [OFFER]
- **SKU:** [SKU]
- **Version:** [VERSION]

## Networking

### Network Interface: [NIC_NAME]
- **Virtual Network:** [VNET_NAME]
- **Subnet:** [SUBNET_NAME]
- **Private IP Address:** [PRIVATE_IP]
- **IP Allocation:** [Static/Dynamic]
- **Public IP Address:** [PUBLIC_IP] or N/A
- **Network Security Group:** [NSG_NAME]

### DNS
- **DNS Servers:** [DNS_SERVERS]
- **FQDN:** [FQDN]

### Load Balancing
- **Load Balancer:** [LB_NAME] or N/A
- **Backend Pool:** [BACKEND_POOL]

## Storage

### OS Disk
- **Name:** [OS_DISK_NAME]
- **Type:** [Managed/Unmanaged]
- **Size:** [SIZE_GB] GB
- **Disk Type:** [Premium_SSD/Standard_SSD/Standard_HDD]
- **Caching:** [ReadWrite/ReadOnly/None]
- **Encryption:** [Enabled/Disabled]

### Data Disks
| Disk Name | LUN | Size (GB) | Type | Caching | Encryption |
|-----------|-----|-----------|------|---------|------------|
| [DISK_1] | [0] | [SIZE] | [TYPE] | [CACHING] | [Yes/No] |
| [DISK_2] | [1] | [SIZE] | [TYPE] | [CACHING] | [Yes/No] |

## Availability & Scalability

- **Availability Zone:** [ZONE] or N/A
- **Availability Set:** [AVAILABILITY_SET] or N/A
- **Virtual Machine Scale Set:** [VMSS_NAME] or N/A
- **Fault Domain:** [FAULT_DOMAIN]
- **Update Domain:** [UPDATE_DOMAIN]

## Monitoring

### Boot Diagnostics
- **Status:** [Enabled/Disabled]
- **Storage Account:** [STORAGE_ACCOUNT]

### Azure Monitor
- **Status:** [Enabled/Disabled]
- **Log Analytics Workspace:** [WORKSPACE_NAME]
- **Performance Counters:** [LIST]

### Metrics
- CPU Utilization: [LINK_TO_METRICS]
- Memory Usage: [LINK_TO_METRICS]
- Disk IOPS: [LINK_TO_METRICS]
- Network Traffic: [LINK_TO_METRICS]

### Alerts
| Alert Name | Condition | Threshold | Action Group |
|------------|-----------|-----------|--------------|
| [ALERT_1] | [CONDITION] | [VALUE] | [ACTION_GROUP] |

## Security

### Identity
- **System Assigned Identity:** [Enabled/Disabled]
- **User Assigned Identities:** [IDENTITY_NAMES]

### Access Control
- **Admin Username:** [USERNAME]
- **Authentication Type:** [Password/SSH/Key]
- **SSH Public Keys:** [KEY_COUNT] configured

### Security Extensions
- **Antimalware:** [Enabled/Disabled] - [VERSION]
- **Vulnerability Assessment:** [Enabled/Disabled]
- **Just-In-Time Access:** [Enabled/Disabled]

### Encryption
- **Azure Disk Encryption:** [Enabled/Disabled]
- **Encryption at Host:** [Enabled/Disabled]
- **Key Vault:** [KEY_VAULT_NAME]

### Network Security
- **NSG Rules Applied:** [NUMBER]
- **Ports Open:** [PORT_LIST]
- **DDoS Protection:** [Basic/Standard]

## Backup & Disaster Recovery

### Backup Configuration
- **Backup Status:** [Enabled/Disabled]
- **Recovery Services Vault:** [VAULT_NAME]
- **Backup Policy:** [POLICY_NAME]
- **Retention:** [DAYS] days
- **Last Backup:** [TIMESTAMP]
- **Backup Frequency:** [DAILY/WEEKLY]

### Site Recovery
- **Replication Status:** [Enabled/Disabled]
- **Target Region:** [REGION]
- **Recovery Point Objective (RPO):** [MINUTES]

## Extensions & Agents

| Extension Name | Version | Status | Auto Upgrade |
|----------------|---------|--------|--------------|
| [EXTENSION_1] | [VERSION] | [Succeeded/Failed] | [Yes/No] |
| [EXTENSION_2] | [VERSION] | [Succeeded/Failed] | [Yes/No] |

## Tags

| Tag Name | Tag Value |
|----------|-----------|
| [TAG_1] | [VALUE_1] |
| [TAG_2] | [VALUE_2] |
| Environment | [Dev/Test/Prod] |
| Owner | [OWNER_NAME] |
| CostCenter | [COST_CENTER] |

## Cost

- **Estimated Monthly Cost:** $[COST]/month
  - Compute: $[COMPUTE_COST]
  - Storage: $[STORAGE_COST]
  - Networking: $[NETWORK_COST]
- **Reserved Instance:** [Yes/No]
- **Cost Center:** [COST_CENTER]

## Maintenance

### Update Management
- **Auto OS Updates:** [Enabled/Disabled]
- **Maintenance Window:** [WINDOW]
- **Last Patched:** [TIMESTAMP]

### Scheduled Events
- **Next Maintenance:** [DATE_TIME]
- **Impact:** [Reboot/Redeploy/None]

## Compliance

- **Azure Policy Compliance:** [PERCENTAGE]%
- **Security Center Recommendations:** [NUMBER] active
- **Regulatory Compliance:** [STANDARDS]

## Dependencies

### Required Services
- [SERVICE_1]
- [SERVICE_2]

### Dependent Services
- [SERVICE_3]
- [SERVICE_4]

## Runbooks

### Startup Procedures
1. [STEP_1]
2. [STEP_2]

### Shutdown Procedures
1. [STEP_1]
2. [STEP_2]

### Disaster Recovery
1. [STEP_1]
2. [STEP_2]

## Troubleshooting

### Common Issues
- **Issue:** [ISSUE_DESCRIPTION]
  - **Solution:** [SOLUTION]

### Logs Location
- **OS Logs:** [PATH]
- **Application Logs:** [PATH]
- **Azure Diagnostics:** [STORAGE_ACCOUNT]

### Support Contacts
- **Primary:** [NAME] - [EMAIL]
- **Secondary:** [NAME] - [EMAIL]
- **On-Call:** [ROTATION_LINK]

## Notes

[ADDITIONAL_NOTES_OR_DOCUMENTATION]

## Change History

| Date | Change | Changed By | Ticket |
|------|--------|------------|--------|
| [DATE] | [CHANGE_DESCRIPTION] | [NAME] | [TICKET_NUMBER] |

## Related Resources

- Architecture Diagram: [LINK]
- Application Documentation: [LINK]
- Network Diagram: [LINK]
- Runbook: [LINK]

---

**Last Updated:** [TIMESTAMP]
**Documented By:** [AUTHOR]
**Review Date:** [NEXT_REVIEW_DATE]
