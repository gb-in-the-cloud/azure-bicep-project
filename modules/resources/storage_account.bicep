param CAFPrefix string
param nameSeperator string
param location string
param tags object

var storageAccontName = toLower('${CAFPrefix}${nameSeperator}stg01')

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccontName
  location: location
  tags: tags

  sku: {
    name: 'Standard_LRS'
  }

  kind: 'StorageV2'

  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false

    encryption: {
      keySource: 'Microsoft.Storage'

      services: {
        queue: {
          keyType: 'Service'
        }

        table: {
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
}
output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name

