
# Get OAuth Token
$scope = "https://api.businesscentral.dynamics.com/.default"

$clientid = "your-client-id-guid" #Application (client) ID from AppRegistration - Azure
$clientsecret = "your-client-secret-value" #value from client secret - Azure
$environment = "EnvironmentName" #Admin Console
$tenantID = "your-tenant-id-guid" #Admin Console
$company = "your-company-guid" #Business Central Company - BusinessCentral

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
# Build

$Header = @{
    Authorization = "$($Request.token_type) $($Request.access_token)"
}

$Req = $null
$get = $null

# Get a list of APIs
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/"

$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$Req

# Get a list of companies
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies"

$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$Req

# get a list of customers
$URL = "https://api.businesscentral.dynamics.com/v2.0/($tenantid)/$($environment)/api/v2.0/companies($($company))/customers()"
$get = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$get

# get a list of customers - specific fields
$URL = "https://api.businesscentral.dynamics.com/v2.0/($tenantid)/$($environment)/api/v2.0/companies($($company))/customers?`$select=number,displayName,balanceDue"
$get = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$get

# get a list of customers - specific fields - filter
$URL = "https://api.businesscentral.dynamics.com/v2.0/($tenantid)/$($environment)/api/v2.0/companies($($company))/customers?`$select=number,displayName,balanceDue&`$filter=number eq '10000'"
$get = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$get


# get a list of sales orders
$URL = "https://api.businesscentral.dynamics.com/v2.0/($tenantid)/$($environment)/api/v2.0/companies($($company))/salesOrders"
$get = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$get

# get a list of sales orders
$URL = "https://api.businesscentral.dynamics.com/v2.0/($tenantid)/$($environment)/api/v2.0/companies($($company))/salesOrders?`$select=orderDate,number,customerNumber,customerName&`$orderby=orderDate"
$get = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$get

# get a list of sales orders for a specific customer
$URL = "https://api.businesscentral.dynamics.com/v2.0/($tenantid)/$($environment)/api/v2.0/companies($($company))/salesOrders()?`$filter=customerNumber eq '10000'"
$get = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$get

# get a Specific sales order and lines
$URL = "https://api.businesscentral.dynamics.com/v2.0/($tenantid)/$($environment)/api/v2.0/companies($($company))/salesOrders()?`$filter=number eq 'S-ORD101009'&`$expand=salesOrderLines"
$get = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$get

###########

# Get a list of our APIs
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/summitNA/sample/v2.0"
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$Req

# Get a list of Widgets
$Req = $null
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/summitNA/sample/v2.0/companies($($company))/widgets"
$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$Req


# create widgets
$Count = 1..20
  foreach ($Num in $Count) {
    $Num
    $ReqBody = @{
        "no" = "$($Num)"
        "description" = "$($Num)"
    } | ConvertTo-Json
    Invoke-RestMethod -Method Post -Uri "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/SummitNA/Sample/v2.0/companies($($company))/widgets" -Headers $Header -Body $ReqBody  -ContentType "application/json"
}
