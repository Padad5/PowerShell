$zones = Get-DnsServerZone -ComputerName DC1 | where {$_.IsDsIntegrated -ne 'True' }
$zones | Select ZoneName,ZoneType,AllowUpdate,@{Name=”MasterServers”;Expression={$_.MasterServers}},@{Name=”SecondaryServers”;Expression={$_.SecondaryServers}},IsDsIntegrated | ft #| Export-Csv DNS.csv -NoTypeInformation
