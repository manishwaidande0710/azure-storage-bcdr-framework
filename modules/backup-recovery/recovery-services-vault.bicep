param location string = 'centralindia'
param vaultName string = 'rsv-core-bcdr-'

// 1. Recovery Services Vault (RSV)
resource recoveryVault 'Microsoft.RecoveryServices/vaults@2023-04-01' = {
  name: vaultName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Disabled' // Zero-trust private access
    securitySettings: {
      softDeleteSettings: {
        softDeleteState: 'Enabled' // 14-day soft delete protection
      }
    }
  }
}

// 2. Production Virtual Machine Backup Policy
resource vmBackupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-04-01' = {
  parent: recoveryVault
  name: 'policy-prod-vm-daily'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 2 // Instant Restore snapshot window
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2026-10-03T23:00:00Z' // Daily 11:00 PM UTC backup
      ]
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-10-03T23:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days' // Retain daily backups for 30 days
        }
      }
      weeklySchedule: {
        daysOfTheWeek: [
          'Sunday'
        ]
        retentionTimes: [
          '2026-10-03T23:00:00Z'
        ]
        retentionDuration: {
          count: 12
          durationType: 'Weeks' // Retain weekly Sunday backups for 12 weeks
        }
      }
    }
  }
}

output vaultId string = recoveryVault.id
output vaultName string = recoveryVault.name
