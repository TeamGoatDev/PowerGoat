#
#
#
#

if((Get-WindowsFeature -Name DNS).Installed -eq $false)
{
    Install-WindowsFeature DNS –IncludeManagementTools
}

Add-DnsServerPrimaryZone -Name achat.corpo.com21 -ZoneFile corpo.com21.dns -DynamicUpdate None
Add-DnsServerResourceRecordA -Name www -ZoneName corpo.com21 -IPv4Address 10.57.154.111