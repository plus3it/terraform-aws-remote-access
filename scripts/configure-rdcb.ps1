[CmdLetBinding()]
Param()
# Script must be run with a domain credential that has admin privileges on the local system

$RequiredFeatures = @(
    "RDS-Connection-Broker",
    "RDS-RD-Server",
    "RDS-Licensing"
)

# Validate required features are installed
$MissingFeatures = @()
foreach ($Feature in (Get-WindowsFeature $RequiredFeatures))
{
    if (-not $Feature.Installed)
    {
        $MissingFeatures += $Feature.Name
    }
}
if ($MissingFeatures)
{
    throw "[$(get-date -format o)]: Missing required Windows features: $($MissingFeatures -join ',')"
}

# Validate availability of RDS Licensing configuration
$null = Import-Module RemoteDesktop,RemoteDesktopServices -Verbose:$false
$TestPath = "RDS:\LicenseServer"
if (-not (Get-ChildItem $TestPath -ErrorAction SilentlyContinue))
{
    throw "[$(get-date -format o)]: System needs to reboot to create the path: ${TestPath}"
}

# Get the system name
$SystemName = [System.Net.DNS]::GetHostByName('').HostName

# Create RD Session Deployment
if (-not (Get-RDServer -ConnectionBroker $SystemName -ErrorAction SilentlyContinue))
{
    New-RDSessionDeployment -ConnectionBroker $SystemName -SessionHost $SystemName
    Write-Verbose "[$(get-date -format o)]: Created the RD Session Deployment!"
}
else
{
    Write-Warning "[$(get-date -format o)]: RD Session Deployment already exists, skipping"
}

# Configure RDS Licensing
Set-Item -path RDS:\LicenseServer\Configuration\Firstname -value "End" -Force
Set-Item -path RDS:\LicenseServer\Configuration\Lastname -value "User" -Force
Set-Item -path RDS:\LicenseServer\Configuration\Company -value "Company" -Force
Set-Item -path RDS:\LicenseServer\Configuration\CountryRegion -value "United States" -Force
$ActivationStatus = Get-Item -Path RDS:\LicenseServer\ActivationStatus
if ($ActivationStatus.CurrentValue -eq 0)
{
    Set-Item -Path RDS:\LicenseServer\ActivationStatus -Value 1 -ConnectionMethod AUTO -Reason 5 -ErrorAction Stop
}
$obj = gwmi -namespace "Root/CIMV2/TerminalServices" Win32_TerminalServiceSetting
$null = $obj.SetSpecifiedLicenseServerList("localhost")
$null = $obj.ChangeMode(2)

Write-Verbose "[$(get-date -format o)]: Configured RD Licensing!"
Write-Verbose "[$(get-date -format o)]: configure-rdcb.ps1 complete!"
