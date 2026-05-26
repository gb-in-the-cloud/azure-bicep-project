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

module storageaccount 'resources/storage_account.bicep' = {
  name: 'storageaccount'

  params: {
    CAFPrefix: CAFPrefix
    nameSeparator: nameSeparator
    location: location
    tags: tags
  }
}

module functionapp 'resources/function_app.bicep' = {
  name: 'functionapp'

  params: {
    CAFPrefix: CAFPrefix
    nameSeparator: nameSeparator
    location: location
    tags: tags
  }
}

module database 'resources/database.bicep' = {
  name: 'database'

  params: {
    CAFPrefix: CAFPrefix
    nameSeparator: nameSeparator
    location: location
    tags: tags

    adminPassword: adminPassword
  }
}
