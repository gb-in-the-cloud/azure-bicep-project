@description('CAF naming prefix')
param CAFPrefix string

@description('Name separator')
param nameSeparator string

@description('Azure region')
param location string

@description('Resource tags')
param tags object
param vnetAddressSpace string = '10.0.0.0/16'
param subnetAddressPrefix string = '10.0.1.0/24'

var vnetName = '${CAFPrefix}${nameSeparator}vnet'
var subnetName = '${CAFPrefix}${nameSeparator}subnet'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  tags: tags

  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressSpace
      ]
    }

    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
        }
      }
    ]
  }
}

output subnetId string = virtualNetwork.properties.subnets[0].id
