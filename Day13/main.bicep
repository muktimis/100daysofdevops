param location string = resourceGroup().location
param storageName string
param vmName string
param adminUsername string
param adminPassword string

resource storage 'Microsoft.storage/storageAccounts@2023-01-01' = {
    name: storageName
    location: location
    sku: {
        name: 'Standard_LRS'
    }
    kind: storageV2
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
    name: '${vmName}-pip'
    location: location
    sku: {
        name: 'Standard'
    }
    properties: {
        publicIPAllocatedMethod: 'Static' 
    }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-04-01' = {
    name: '${vmName}-nic'
    location: location
    properties: {
        ipConfigurations: [
            {
                name: 'ipconfig1'
                properties : {
                    publicIPAllocatedMethod: 'Dynamic'
                    publicIPAddresses: {
                        id: publicIP.id
                    }
                }
            }
        ]
    }
}

resource vm "Microsoft.Compute/virtualMachines@2023-09-01' = {
    name: vmName
    location: location 
    properties: {
        hardwareProfile: {
            vmSize: 'Standard_B1s'
        }
        osProfile: {
            computerName: vmName
            adminUsername: adminUsername
            adminPassword: adminPassword
        }
        storageProfile: {
            imageReference: {
                publisher: 'Canonical'
                offer: '0001-com-ubuntu-server-focal'
                sku: '20_04-lts'
                version: 'latest'   
            }
            osDisk: {
                createOption: 'FromImage'
            }
        }
        networkProfile: {
            networkInterfaces: [
                {
                    id: nic.id
                }
            ]
        }

    }
}