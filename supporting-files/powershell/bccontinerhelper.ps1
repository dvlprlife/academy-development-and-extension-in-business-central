############################################################################################################
# Set these values

$containername = 'BC23'
$version = 23
$UserName = 'admin'
$Password = 'password'
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName,$SecurePassword)

############################################################################################################

$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$startTime : Container load start"

$artifactUrl = Get-BCArtifactUrl -version $version -country "us" -select Latest -type Sandbox
Write-Host -ForegroundColor Yellow ($artifactUrl)

New-BCContainer  `
    -accept_eula `
    -accept_outdated `
    -alwaysPull `
    -artifactUrl $artifactUrl `
    -auth NavUserPassword `
    -containerName $containername `
    -Credential $Credential `
    -includeAL `
    -isolation hyperv `
    -updateHosts

$timespend = [Math]::Round([DateTime]::Now.Subtract($startTime).Totalseconds)
$stopTime = [DateTime]::Now

Write-Host -ForegroundColor Green "$stopTime : Container load took $timespend seconds"



