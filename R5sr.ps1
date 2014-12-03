#
#
#
#

if((Get-WindowsFeature -Name DNS).Installed -eq $false)
{
    Install-WindowsFeature DNS –IncludeManagementTools
}

Add-DnsServerPrimaryZone -Name corpo.com21 -ZoneFile corpo.com21.dns -DynamicUpdate None
Add-DnsServerResourceRecordA -Name www -ZoneName corpo.com21 -IPv4Address 10.57.154.111
Add-DnsServerResourceRecordA -Name www.vendeur -ZoneName corpo.com21 -IPv4Address 10.57.154.111
Add-DnsServerResourceRecordA -Name intranet -ZoneName vendeur.corpo.com21 -IPv4Address 10.57.154.111
Add-DnsServerResourceRecordA -Name doc -ZoneName corpo.com21 -IPv4Address 10.57.154.111

Add-DnsServerZoneDelegation -ChildZoneName achat -IPAddress 10.57.154.112 -Name corpo.com21 -NameServer 529S2V21