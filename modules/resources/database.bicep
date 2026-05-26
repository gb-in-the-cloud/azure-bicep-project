param CAFPrefix string
param nameSeparator string  
param location string
param tags object
@secure()
param adminPassword string

var sqlServerName = toLower('${CAFPrefix}${nameSeparator}sql01')
var databaseName = '${CAFPrefix}${nameSeparator}db01'

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlServerName
  location: location
  tags: tags

  properties: {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: adminPassword
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
  }

  resource database 'databases@2021-02-01-preview' = {
    name: databaseName
    location: location

    properties: {
      createMode: 'Default'
      autoPauseDelay: 0
      highAvailabilityReplicaCount: 0
      isLedgerOn: false 
      licenseType: 'LicenseIncluded'

      maintenanceConfigurationId: resourceId('Microsoft.Sql/servers/maintenanceConfigurations', sqlServerName, 'Default')

      minCapacity:0
      readScale: 'Disabled'
      requestedBackupStorageRedundancy: 'Geo'
      zoneRedundant: false
    }
  }
}
output sqlServerId string = server.id
output databaseId string = server::database.id
