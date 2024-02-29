@description('Azure location for deployment')
param location string = resourceGroup().location
param storageName string = '${namePrefix}${uniqueString (resourceGroup().id)}'
param namePrefix string = 'marco'

param dockerImage string = 'nginx' //'nginxdemos/hello'
param dockerImageTag string = 'latest'

targetScope = 'resourceGroup'

module storage 'modules/storage.bicep' = {
  name: 'storageName'
  params: {
    storageName:storageName
    location:location 
  }
}

module appPlanDeploy 'modules/serviceplan.bicep' = {
  name: 'appPlanDeploy'
  params: {
    namePrefix: namePrefix
    location: location
  }
}

module deployWebsite 'modules/webapp.bicep' = {
  name: '${namePrefix}-deploy-Website'
  params: {
    appPlanId: appPlanDeploy.outputs.planId
    location:location
    dockerImage:dockerImage
    dockerImageTag:dockerImageTag
  }
}
output siteUrl string = deployWebsite.outputs.siteUrl




