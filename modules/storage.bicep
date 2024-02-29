@minLength(5)
@maxLength(24)
@description('StorageName must have min 5 chars and a max of 24 chars')

param namePrefix string = 'marco'
param storageName string = '${namePrefix}${uniqueString (resourceGroup().id)}'
param location string = resourceGroup().location

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}
