#
#
#
#

if((Get-WindowsFeature -Name DNS).Installed -eq $false)
{
    Install-WindowsFeature DNS –IncludeManagementTools
}

Add-DnsServerForwarder -IPAddress 10.57.154.110

Add-DnsServerPrimaryZone -Name gestion.ca21 -ZoneFile gestion.ca21.dns -DynamicUpdate None
Add-DnsServerResourceRecordA -Name prof -ZoneName gestion.ca21 -IPv4Address 10.57.100.100
Add-DnsServerResourceRecordA -Name ww1 -ZoneName gestion.ca21 -IPv4Address 10.57.154.111
Add-DnsServerResourceRecordA -Name ww2 -ZoneName gestion.ca21 -IPv4Address 10.57.154.111


Add-DnsServerPrimaryZone -Name achat.corpo.com21 -ZoneFile corpo.com21.dns -DynamicUpdate None
Add-DnsServerResourceRecordA -Name www -ZoneName corpo.com21 -IPv4Address 10.57.154.111

Add-DnsServerConditionalForwarderZone -Name prof.B54 -MasterServers 10.57.100.100