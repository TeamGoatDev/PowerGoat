#
#
#
#

if((Get-WindowsFeature -Name DNS).Installed -eq $false)
{
    Install-WindowsFeature DNS –IncludeManagementTools
}

Add-DnsServerForwarder -IPAddress 10.57.100.100

Add-DnsServerPrimaryZone -Name corpo.com21 -ZoneFile corpo.com21.dns -DynamicUpdate None
Add-DnsServerResourceRecordA -Name www -ZoneName corpo.com21 -IPv4Address 10.57.154.111
Add-DnsServerResourceRecordA -Name www.vendeur -ZoneName corpo.com21 -IPv4Address 10.57.154.111
Add-DnsServerResourceRecordA -Name intranet.vendeur -ZoneName corpo.com21 -IPv4Address 10.57.154.111
Add-DnsServerResourceRecordA -Name doc -ZoneName corpo.com21 -IPv4Address 10.57.154.111
Add-DnsServerResourceRecordA -Name perso -ZoneName corpo.com21 -IPv4Address 10.57.154.111

Add-DnsServerZoneDelegation -ChildZoneName achat -IPAddress 10.57.154.112 -Name corpo.com21 -NameServer 529S2V21

Add-DnsServerSecondaryZone -Name prof.B54 -ZoneFile prof.B54.dns -MasterServers 10.57.100.100