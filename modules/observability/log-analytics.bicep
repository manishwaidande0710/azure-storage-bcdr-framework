param location string = 'centralindia'
param workspaceName string = 'law-core-monitoring-'

// 1. Central Log Analytics Workspace
resource logWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018' // Pay-as-you-go with 5GB/month free ingestion
    }
    retentionInDays: 30 // 30-day operational retention (free tier limit)
    workspaceCapping: {
      dailyQuotaGb: 1 // Daily cap to guarantee zero surprise costs
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

output workspaceId string = logWorkspace.id
output workspaceName string = logWorkspace.name
output workspaceCustomerId string = logWorkspace.properties.customerId
