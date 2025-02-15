param name string
param location string = resourceGroup().location
param tags object = {}

param allowedOrigins array = []
param appCommandLine string = ''
param applicationInsightsName string = ''
param appServicePlanId string
param appSettings object = {}
param useAuthSettingsv2 bool = false
param keyVaultName string
param serviceName string = 'sap-cloud-sdk-api'
param healthCheckPath string = '/health'
param use32BitWorkerProcess bool = false

param alwaysOn bool = true

module api '../core_local/host/appservice.bicep' = {
  name: '${name}-app-module'
  params: {
    name: name
    location: location
    tags: union(tags, { 'azd-service-name': serviceName })
    allowedOrigins: allowedOrigins
    appCommandLine: appCommandLine
    applicationInsightsName: applicationInsightsName
    appServicePlanId: appServicePlanId
    appSettings: appSettings
    useAuthSettingsv2: useAuthSettingsv2
    keyVaultName: keyVaultName
    runtimeName: 'node'
    runtimeVersion: '18-lts'
    scmDoBuildDuringDeployment: true
    healthCheckPath: healthCheckPath
    use32BitWorkerProcess: use32BitWorkerProcess
    alwaysOn: alwaysOn
  }
}

output SERVICE_API_IDENTITY_PRINCIPAL_ID string = api.outputs.identityPrincipalId
output SERVICE_API_NAME string = api.outputs.name
output SERVICE_API_URI string = api.outputs.uri
