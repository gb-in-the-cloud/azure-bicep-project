@description('CAF naming prefix')
param CAFPrefix string

@description('Name separator')
param nameSeparator string

@description('Azure region')
param location string

@description('Resource tags')
param tags object

@description('Subnet ID')
param subnetId string

@description('Admin username')
param adminUsername string
//@secure() prevents:deployment logs exposing secrets
@secure()
param adminPassword string

//CAFPrefix == Cloud Adoption Framework Prefix
//NIC == Network Interface Card
//nic == network interface
//pip == public ip address
//sku == stock keeping unit
var vmName = '${CAFPrefix}${nameSeparator}vm01'
var nicName = '${CAFPrefix}${nameSeparator}nic01'
var pipName = '${CAFPrefix}${nameSeparator}pip01'

resource publicIp 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: pipName
  location: location
  tags: tags

  sku: {
    name: 'Standard'
  }

  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: nicName
  location: location
  tags: tags

  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'

        properties: {
          subnet: {
            id: subnetId
          }

          privateIPAllocationMethod: 'Dynamic'

          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName
  location: location
  tags: tags

  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }

    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }

    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }

      osDisk: {
        createOption: 'FromImage'

        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
  }
}
