#
#
#
#

if((Get-WindowsFeature -Name DNS).Installed -eq $false)
{
    Install-WindowsFeature DNS –IncludeManagementTools
}

Add-DnsServerPrimaryZone -Name vendeur.corpo.com21 -ZoneFile corpo.com21.dns -DynamicUpdate None