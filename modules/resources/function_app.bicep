param CAFPrefix string
param nameSeperator string
param location string
param tags object

var appServicePlanName = '${CAFPrefix}${nameSeperator}asp01'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  tags: tags

  sku: {
    name: 'S1'
    capacity: 1
    tier: 'Standard'
  }

  properties: {
    reserved: false
    perSiteScaling: false
    hyperV: false
    zoneRedundant: false
  }
}
output appServicePlanId string = appServicePlan.id
