###############################################################################################################################################################
# This is version 1.1 of a Simple Firewall Inventory.                                                                                                         #  
# Courtesy of Testbench Labs LLC Web: https://www.testbenchlabs.com                                                                                           #  
# email:support@TestbenchLabs                                                                                                                                 #                                      
# github:https://github.com/ApplicationsEngineering/-Powershell"                                                                                              #
#                                                                                                                                                             #
# PREREQUISITE_______________________________________________________________________________________________________________________________________________ #
# Run the script from a Powershell Terminal with command: .\firewall_rpt.ps1                                                                                  #                                  
# This script will produce a report of all enabled firewall rules on the local machine and save it to C:\temp\FirewallReport.txt                              #
# The report will include the following properties for each enabled firewall rule                                                                             # 
# Make sure you have created a directory of C:\temp if you already haven't done so. The report will be saved to: C:\temp\FirewallReport.txt                   #
###############################################################################################################################################################

Write-Progress "Welcome to the Simple Firewall Inventory Scanner 1.1"
Start-Sleep -Seconds 5
Write-Progress "Courtesy of Testbench Labs LLC Web: https://www.testbenchlabs.com" 
Start-Sleep -Seconds 5
Write-Progress "Please create a directory of C:\temp if you already haven't done so."
Start-Sleep -Seconds 25
Write-Progress "Firewall report will be saved to: C:\temp\FirewallReport.txt shortly...."
# Get-NetFirewallProfile -PolicyStore ActiveStore
$firewallRules = Get-NetFirewallRule | Where-Object {$_.Enabled -eq "True"}
$report = foreach ($rule in $firewallRules) {
    $portFilter = Get-NetFirewallPortFilter -AssociatedNetFirewallRule $rule
    $addressFilter = Get-NetFirewallAddressFilter -AssociatedNetFirewallRule $rule

# Create a custom object with the desired properties
    [PSCustomObject]@{
        DisplayName     = $rule.DisplayName
        Direction       = $rule.Direction
        Action          = $rule.Action
        Profile         = $rule.Profile
        Enabled         = $rule.Enabled
        Protocol        = $portFilter.Protocol
        LocalPort       = $portFilter.LocalPort
        RemotePort      = $portFilter.RemotePort
        RemoteAddress   = $addressFilter.RemoteAddress
        Description     = $rule.Description
    }
}
Start-Sleep -Seconds 5
$report | Out-File -FilePath "C:\temp\FirewallReport.txt" -Encoding UTF8
Start-Sleep -Seconds 5
Write-Host "Firewall report has been saved to: C:\temp\FirewallReport.txt" 
Start-Sleep -Seconds 5
Write-Host "Script execution completed successfully."
