########################
# PowerShell Script to interact with Microsoft Dynamics 365 Business Central APIs
# This script is for demonstration purposes only.
# Please make sure to handle secrets and sensitive information securely in production environments.
# Replace the placeholder values with your actual configuration.
#
########################

########################
# Get OAuth Token
$scope = "https://api.businesscentral.dynamics.com/.default"
$InformationPreference = "Continue"

$clientid = "your-client-id-guid" #Application (client) ID from AppRegistration - Azure
$clientsecret = "your-client-secret-value" #value from client secret - Azure
$environment = "EnvironmentName" #Admin Console
$newEnvironmentName = 'NewEnvironmentName' # User Defined
$tenantID = "your-tenant-id-guid" #Admin Console
$company = "your-company-guid" #Business Central Company - BusinessCentral
$adminApiVersion = "v2.28" # Admin API Version

$AuthHeader = @{
    'Content-Type' = 'application/x-www-form-urlencoded'
}

$Body = @{
    grant_type='client_credentials'
    client_id=$clientid
    client_secret=$clientsecret
    scope=$scope
}

$Request = Invoke-RestMethod -Method POST -uri "https://login.microsoftonline.com/$($tenantid)/oauth2/v2.0/token" -Headers $AuthHeader -Body $Body

$Header = @{
    Authorization = "$($Request.token_type) $($Request.access_token)"
}

$Req = $null
########################


########################
# Admin Center API

### Get a list of Environments
$URL = "https://api.businesscentral.dynamics.com/admin/$($adminApiVersion)/applications/businesscentral/environments"
Write-Information "Fetching environments from Business Central Admin Center..."
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
Write-Information ("Found {0} environments." -f $Req.Value.Count)
$Req
###

### Delete an Environment
$URL = "https://api.businesscentral.dynamics.com/admin/$($adminApiVersion)/applications/businesscentral/environments/$($environment)"
Write-Information ("Deleting Environment {0}." -f $($environment))
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Delete -Uri $URL -Headers $Header).Value

$Req
###

### Create an Environment
# "environmentType": string, // The type of environment to create (enum | "Production", "Sandbox")
#  "countryCode": string, // The country to create the environment within
# ("ringName": string), // Optional - The logical ring group to create the environment within. Currently only Sandbox type environments may be created in a 'Preview' ring. If not provided then the production ring will be used.
# ("applicationVersion": Version), // Optional - the version of the application the environment should be created on. If not provided then the latest available version will be used.


$ReqBody = @{
    "environmentType" = "Sandbox"
    "countryCode" = "US"
} | ConvertTo-Json
$URL = "https://api.businesscentral.dynamics.com/admin/$($adminApiVersion)/applications/businesscentral/environments/$($environment)"
Write-Information ("Creating Environment {0}." -f $($environment))
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method PUT -Uri $URL -Headers $Header -Body $ReqBody  -ContentType "application/json").Value

$Req
###

### Rename Environment
$ReqBody = @{
    "NewEnvironmentName" = $($newEnvironmentName)
} | ConvertTo-Json
$URL = "https://api.businesscentral.dynamics.com/admin/$($adminApiVersion)/applications/businesscentral/environments/$($environment)/rename"
Write-Information ("Renaming Environment {0} to {1}." -f $($environment),$($newEnvironmentName))
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method POST -Uri $URL -Headers $Header -Body $ReqBody  -ContentType "application/json").Value

$Req
###
########################

########################
# API

### Get a list of APIs
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$Req
###

### Get a list of companies
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

### get a list of customers
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies($($company))/customers"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

### get a list of customers - specific fields
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies($($company))/customers?`$select=number,displayName,balanceDue"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

### get a list of customers - specific fields - filter
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies($($company))/customers?`$select=number,displayName,balanceDue&`$filter=number eq '10000'"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

### insert a customers
$ReqBody = @{
    "displayName" = "Test"
    "addressLine1" = "Address 1"
    "addressLine2" = "Address 2"
    "city" = "City"
    "state" = "State"
    "postalCode" = "00000"
} | ConvertTo-Json
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Post -Uri "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies($($company))/customers()" -Headers $Header -Body $ReqBody  -ContentType "application/json").Value

$Req
###

### get a list of sales orders
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies($($company))/salesOrders"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

### get a list of sales orders - specific fields
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies($($company))/salesOrders?`$select=orderDate,number,customerNumber,customerName&`$orderby=orderDate"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

### get a list of sales orders for a specific customer
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies($($company))/salesOrders?`$filter=customerNumber eq '10000'"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

### get a Specific sales order and lines
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies($($company))/salesOrders?`$filter=number eq 'S-ORD101009'&`$expand=salesOrderLines"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

########################
### Get a list of Sample APIs
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/summitNA/sample/v2.0"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

### Get a list of Widgets
$Req = $null
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/summitNA/sample/v2.0/companies($($company))/widgets"
Write-Information ("Endpoint: {0}" -f $URL)
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value

$Req
###

### create widgets
$Count = 1..20
  foreach ($Num in $Count) {
    $Num
    $ReqBody = @{
        "no" = "$($Num)"
        "description" = "$($Num)"
    } | ConvertTo-Json
    Invoke-RestMethod -Method Post -Uri "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/SummitNA/Sample/v2.0/companies($($company))/widgets" -Headers $Header -Body $ReqBody  -ContentType "application/json"
}
###
########################
