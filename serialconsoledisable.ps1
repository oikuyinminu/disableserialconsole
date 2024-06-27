<# 
Script Name: Disable-Serial-Console.ps1
Purpose: Powershell script for disabling Serial Console from the subscription level
Author: Banji IKUYINMINU
Last Modified: 26/06/2024
Status: Final
Version: 1.0
#>


param (
    [Parameter(Mandatory = $true)][string]$SubscriptionName
)

# First login to the specified subscription
$subscription = Get-AzSubscription -SubscriptionName $SubscriptionName
Set-AzContext -Subscription $subscription

# Get the current subscription ID
$subscriptionId = (Get-AzContext).Subscription.Id

try {
    # Perform the action to disable the console service
    Invoke-AzResourceAction -Action disableConsole -ResourceId "/subscriptions/$subscriptionId/providers/Microsoft.SerialConsole/consoleServices/default" -ApiVersion "2018-05-01" -Force
    Write-Host "Console service disabled for subscription: $($subscription.Name) ($($subscription.Id))"
} catch {
    Write-Host "Failed to disabled console service for subscription: $($subscription.Name) ($($subscription.Id)). Error: $_"
}
