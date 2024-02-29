param namePrefix string = 'marco'
param appPlanId string
param location string = resourceGroup().location

param dockerImage string = 'nginx' //nginxdemos/hello'
param dockerImageTag string = 'latest'

resource webApplication 'Microsoft.Web/sites@2023-01-01' = {
  name: '${namePrefix}-webApp20242029'
  location: location
  properties: {
    serverFarmId: appPlanId
    //httpsOnly: true
    siteConfig: {
      appSettings: [
       {
        name: 'DOCKER_REGISTRY_SERVICE_URL'
        value:'https://index.docker.io'
       }
       {
        name:'DOCKER_REGISTRY_SERVER_USERNAME'
        value:''  
       }
       {
        name:'DOCKER_REGISTRY_SERVER_PASSWORD'
        value:'' 
       }
       {
        name:'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
        value:'false'  
       }
      ]
      linuxFxVersion:'DOCKER |${dockerImage}:${dockerImageTag}'
    }
  }
}
output siteUrl string = webApplication.properties.hostNames[0]
