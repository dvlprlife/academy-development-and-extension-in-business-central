
# Get OAuth Token
$scope = "https://api.businesscentral.dynamics.com/.default"

$clientid = "your-client-id-guid"
$clientsecret = "your-client-secret-guid"
$environment = "Sandbox-guid"
$tenantID = "your-tenant-id-guid"
$company = "your-company-guid"

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

# Get a list of Companies
$URL = "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/v2.0/companies"

$Req = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$Req

# get a list of Sales Orders
$URL = "https://api.businesscentral.dynamics.com/v2.0/($tenantid)/$($environment)/api/v2.0/companies($($company))/salesOrders"
$get = (Invoke-RestMethod -Method Get -Uri $URL -Headers $Header).Value
$URL
$get

# Get a list of APIs
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

$Count = 1..20
  foreach ($Num in $Count) {
    $Num
    $ReqBody = @{
        "no" = "$($Num)"
        "description" = "$($Num)"
    } | ConvertTo-Json
    Invoke-RestMethod -Method Post -Uri "https://api.businesscentral.dynamics.com/v2.0/$($tenantid)/$($environment)/api/SummitNA/Sample/v2.0/companies($($company))/widgets" -Headers $Header -Body $ReqBody  -ContentType "application/json"
}
