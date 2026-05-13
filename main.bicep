param resourceGroupName string = resourceGroup().name
param location string = resourceGroup().location

param CAFPrefix string = 'corp-prod'
param nameSeparator string = '-'

param tags object = {
  Environment: 'Production'
  Owner: 'PlatformTeam'
}

param adminUsername string = 'azureuser'

@secure()
param adminPassword string

module submodule './modules/submodule.bicep' = {
  scope: resourceGroup(resourceGroupName)

  name: 'submodule'

  params: {
    CAFPrefix: CAFPrefix
    nameSeparator: nameSeparator
    location: location
    tags: tags
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}
