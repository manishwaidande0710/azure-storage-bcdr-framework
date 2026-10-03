# Enterprise Azure Storage Security, Backup & BCDR Framework

An automated, Infrastructure-as-Code (IaC) storage architecture and business continuity framework for Microsoft Azure, enforcing zero-trust data protection, automated tiering, WORM immutability, and centralized KQL monitoring at ** compute cost**.

## 📌 Architecture Highlights
- **Zero-Trust Secure Storage**: Public network access disabled, enforced TLS 1.2+, and disabled shared access keys to mandate Microsoft Entra ID RBAC.
- **Automated Lifecycle Management**: Cost-optimization rules transitioning blobs from **Hot $\longrightarrow$ Cool (30d) $\longrightarrow$ Archive (90d) $\longrightarrow$ Expired (365d)**.
- **WORM Immutability Policies**: Time-based tamper-proof retention protecting backup containers against ransomware and unauthorized deletion.
- **Business Continuity & Disaster Recovery (BCDR)**: Centralized **Recovery Services Vault (RSV)** with automated backup policies, soft-delete, and cross-region restore (CRR) readiness.
- **Centralized Observability (KQL)**: Azure Monitor Log Analytics workspace with production-grade Kusto queries detecting unauthorized access attempts and operational alerts.

## 📂 Repository Layout
\\\	ext
├── main.bicep                      # Master deployment orchestrator
├── modules/
│   ├── storage/                   # Storage Account, Lifecycle, & Immutability (Bicep)
│   ├── backup-recovery/           # Recovery Services Vault & Backup policies (Bicep)
│   └── observability/             # Log Analytics & KQL security rules (Bicep/KQL)
├── tests/                         # Automated validation test suite
└── docs/                          # AZ-104 storage & BCDR revision notes
\\\
"@ | Out-File -FilePath README.md -Encoding utf8



@"
param location string = 'centralindia'
param storageAccountName string = 'stsecbcdr'

// 1. Secure Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS' // Low-cost Locally Redundant Storage
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false      // Prevent anonymous public access
    allowSharedKeyAccess: false       // Force Entra ID RBAC authentication
    publicNetworkAccess: 'Disabled'   // Zero-trust network boundary
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
  }
}

// 2. Blob Service with Soft Delete Protection
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 14 // Soft delete recovery window
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 14
    }
  }
}

// 3. Automated Lifecycle Management Policy
resource lifecycleManagement 'Microsoft.Storage/storageAccounts/managementPolicies@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    policy: {
      rules: [
        {
          name: 'AutoTierAndCleanupPolicy'
          enabled: true
          type: 'Lifecycle'
          definition: {
            filters: {
              blobTypes: [
                'blockBlob'
              ]
            }
            actions: {
              baseBlob: {
                tierToCool: {
                  daysAfterModificationGreaterThan: 30
                }
                tierToArchive: {
                  daysAfterModificationGreaterThan: 90
                }
                delete: {
                  daysAfterModificationGreaterThan: 365
                }
              }
            }
          }
        }
      ]
    }
  }
}

output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
