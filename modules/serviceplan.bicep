param namePrefix string = 'marco'
param location string = resourceGroup().location
param sku string = 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: '${namePrefix}-appServicePlan20240229'
  location: location
  kind:'linux'
  sku: {
    name: sku
    capacity: 1
  }
  properties: {
    reserved:true
  }
}
output planId string = appServicePlan.id
