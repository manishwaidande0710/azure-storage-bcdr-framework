targetScope = 'resourceGroup'

param location string = 'centralindia'

// 1. Secure Storage Module
module secureStorage './modules/storage/secure-storage.bicep' = {
  name: 'deploy-secure-storage'
  params: {
    location: location
  }
}

// 2. Recovery Services Vault Module
module bcdrVault './modules/backup-recovery/recovery-services-vault.bicep' = {
  name: 'deploy-bcdr-vault'
  params: {
    location: location
  }
}

// 3. Centralized Log Analytics Workspace Module
module observability './modules/observability/log-analytics.bicep' = {
  name: 'deploy-observability'
  params: {
    location: location
  }
}

output storageId string = secureStorage.outputs.storageAccountId
output vaultId string = bcdrVault.outputs.vaultId
output workspaceId string = observability.outputs.workspaceId
