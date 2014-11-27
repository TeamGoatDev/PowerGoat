#
#
#
#

if((Get-WindowsFeature -Name DNS).Installed -eq $false)
{
    Install-WindowsFeature DNS –IncludeManagementTools
}

Add-DnsServerPrimaryZone -Name corpo.com21 -ZoneFile corpo.com21.dns -DynamicUpdate None
Add-DnsServerSecondaryZone -Name 