@description('CAF naming prefix')
param CAFPrefix string

@description('Name separator')
param nameSeparator string

@description('Azure region')
param location string

@description('Tags')
param tags object

@description('Admin username')
param adminUsername string

@secure()
param adminPassword string

module virtualnetwork 'resources/virtual_network.bicep' = {
  name: 'virtualnetwork'

  params: {
    CAFPrefix: CAFPrefix
    nameSeparator: nameSeparator
    location: location
    tags: tags
  }
}

module virtualmachine 'resources/virtual_machine.bicep' = {
  name: 'virtualmachine'

  params: {
    CAFPrefix: CAFPrefix
    nameSeparator: nameSeparator
    location: location
    tags: tags

    subnetId: virtualnetwork.outputs.subnetId

    adminUsername: adminUsername
    adminPassword: adminPassword
  }

}
