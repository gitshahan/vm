# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' porperty is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

# Input parameters for the VM
$resourceGroupName = "SHARED"
$vmName = "aucscrvm"

# Authenticate with Managed Identity
$AzContext = (Connect-AzAccount -Identity).context
Set-AzContext -SubscriptionId $AzContext.Subscription.Id

Write-Output "Starting VM: $vmName in Resource Group: $resourceGroupName"
Start-AzVM -ResourceGroupName $resourceGroupName -Name $vmName
Write-Output "VM started successfully."